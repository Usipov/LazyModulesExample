public protocol LazyDIFactoryInfoProvider: class {
    var lazilyRegisteredTypes: Set<String> { get }
    var moduleName: String { get }
    var lazyDIFactoryClassName: String { get }
}
