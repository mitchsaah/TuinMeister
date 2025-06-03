import Foundation
import CoreBluetooth

class BLEManager: NSObject, ObservableObject {
    private var centralManager: CBCentralManager!

    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
}

extension BLEManager: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        print("[BLEManager] Bluetooth state: \(central.state.rawValue)")
    }
}
