import Interfaces

final class Protocol1Impl: Protocol1 {
    // MARK: - Protocol1
    func printFromProtocol1() {
        print("In Feature1. Printing from class named: \(type(of: self))")
    }
}
