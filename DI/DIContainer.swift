public final class DIContainer {
    private var factories = [String: () -> Any]()
    private var lazyDIFactoryInfoProviders = [LazyDIFactoryInfoProvider]()
    private let lazyModulesLoader = LazyModulesLoader()
    
    public init() {}
    
    public func register<T>(
        factory: @escaping () -> T)
    {
        checkIsMainThread()
        
        let key = String(describing: T.self)
        
        factories[key] = factory
    }
    
    public func resolve<T>() -> T
    {
        checkIsMainThread()
        
        let key = String(describing: T.self)
        
        // Try once
        if let factory = factories[key] {
            if let result = factory() as? T {
                return result
            }
        } else {
            // Search for a lazy factory
            if let index = lazyDIFactoryInfoProviders.index(where: { lazyDIFactoryInfoProvider in
                lazyDIFactoryInfoProvider.lazilyRegisteredTypes.contains { lazilyRegisteredType in
                    key == lazilyRegisteredType
                    || key == lazyDIFactoryInfoProvider.moduleName + "." + lazilyRegisteredType
                }
            })
            {
                let lazyDIFactoryInfoProvider = lazyDIFactoryInfoProviders.remove(at: index)
                
                // Load lazy module if needed
                if let lazyDIFactory = lazyModulesLoader.instantiateClass(
                    named: lazyDIFactoryInfoProvider.lazyDIFactoryClassName,
                    in: lazyDIFactoryInfoProvider.moduleName
                ) as? LazyDIFactory
                { 
                    // Register depedencies lazily
                    lazyDIFactory.registerDependencies(in: self)
                    
                    // Try resolving again
                    if let factory = factories[key] {
                        if let result = factory() as? T {
                            return result
                        }
                    }
                }
            }
        }
        
        fatalError("Failed to resolve: \(key)")
    }
    
    public func addLazyDIFactoryInfoProvider(_ provider: LazyDIFactoryInfoProvider) {
        checkIsMainThread()
        
        lazyDIFactoryInfoProviders.append(provider)
    }
    
    private func checkIsMainThread() {
        guard Thread.isMainThread else {
            fatalError("It is a demo project")
        }
    }
}
