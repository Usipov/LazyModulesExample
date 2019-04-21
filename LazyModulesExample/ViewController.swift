import UIKit
import DI
import Interfaces

final class ViewController: UIViewController {
    @IBAction func loadModule1() {
        printWillLoadFeature(named: "Feature1")
        let protocol1Instance = AppDelegate.instance.container.resolve() as Protocol1
        protocol1Instance.printFromProtocol1()
    }
    
    @IBAction func loadModule2() {
        printWillLoadFeature(named: "Feature2")
        let protocol2Instance = AppDelegate.instance.container.resolve() as Protocol2
        protocol2Instance.printFromProtocol2()
    }
    
    private func printWillLoadFeature(named featureName: String) {
        print("""
        Will load \(featureName) if it is not loaded yet.
          See dyld logs in the console.
          Make sure 'Dynamic Library Loads' is enabled in 'Scheme -> Run -> Diagnostics'
        """)
    }
}

