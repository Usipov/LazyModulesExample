public protocol LazyDIFactory: NSObjectProtocol {
    func registerDependencies(in container: DIContainer)
}
