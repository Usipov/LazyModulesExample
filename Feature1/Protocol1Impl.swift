import Interfaces

final class Protocol1Impl: Protocol1 {
    func printFromProtocol1() {
        print("In Feature1: \(type(of: self))")
    }
}
