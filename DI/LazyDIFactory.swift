// `NSObjectProtocol` is required to instantiate implementations using `[NSClassFromString(@"...") new]`
// See `LazyModulesLoader.m`
public protocol LazyDIFactory: NSObjectProtocol {
    func registerDependencies(in container: DIContainer)
}
