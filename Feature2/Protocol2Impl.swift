import Interfaces

final class Protocol2Impl: Protocol2 {
    // MARK: - Protocol2
    func printFromProtocol2() {
        print("In Feature2. Printing from class named: \(type(of: self))")
    }
}
