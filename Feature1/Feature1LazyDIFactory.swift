import DI
import Interfaces

final class Feature1LazyDIFactory: NSObject, LazyDIFactory {
    func registerDependencies(in container: DIContainer) {
        container.register {
            Protocol1Impl() as Protocol1
        }
    }
}
