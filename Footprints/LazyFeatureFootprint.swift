import DI

final class LazyFeatureFootprint: LazyDIFactoryInfoProvider {
    let lazilyRegisteredTypes: Set<String>
    let moduleName: String
    let lazyDIFactoryClassName: String
    
    init(
        lazilyRegisteredTypes: Set<String>,
        moduleName: String,
        lazyDIFactoryClassName: String)
    {
        self.lazilyRegisteredTypes = lazilyRegisteredTypes
        self.moduleName = moduleName
        self.lazyDIFactoryClassName = lazyDIFactoryClassName
    }
}
