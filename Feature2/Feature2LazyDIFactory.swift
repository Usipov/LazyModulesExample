import DI
import Interfaces

final class Feature2LazyDIFactory: NSObject, LazyDIFactory {
    func registerDependencies(in container: DIContainer) {
        container.register {
            Protocol2Impl() as Protocol2
        }
    }
}
