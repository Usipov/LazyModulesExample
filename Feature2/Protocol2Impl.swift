import Interfaces

final class Protocol2Impl: Protocol2 {
    func printFromProtocol2() {
        print("In Feature2: \(type(of: self))")
    }
}
