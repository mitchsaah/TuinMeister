import Foundation
import CoreBluetooth

class BLEManager: NSObject, ObservableObject {
    @Published var peripherals: [CBPeripheral] = []
    @Published var isScanning = false
    @Published var isConnected = false
    @Published var connectError: String?

    private var centralManager: CBCentralManager!
    var connectedPeripheral: CBPeripheral?
    private var writeCharacteristic: CBCharacteristic?
    private var statusCharacteristic: CBCharacteristic?
    
    private let serviceUUID  = CBUUID(string: "ABF00000-0000-0000-0000-000000000000")
    private let writeUUID    = CBUUID(string: "ABF10000-0000-0000-0000-000000000000")
    private let statusUUID   = CBUUID(string: "ABF20000-0000-0000-0000-000000000000")

    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    func restartScan() {
        guard centralManager.state == .poweredOn else {
            print("[BLEManager] Bluetooth inactive, no scanning available.")
            return
        }
        peripherals.removeAll()
        isScanning = true
        print("[BLEManager] Start BLE-scan...")
        centralManager.scanForPeripherals(withServices: [serviceUUID], options: nil)
    }
    
    func connect(to peripheral: CBPeripheral) {
        guard centralManager.state == .poweredOn else {
            print("[BLEManager] bluetooth not available.")
            return
        }
        centralManager.stopScan()
        isScanning = false
        connectedPeripheral = peripheral
        peripheral.delegate = self
        print("[BLEManager] Connecting with '\(peripheral.name ?? "unknown")'")
        centralManager.connect(peripheral, options: nil)
    }
}

extension BLEManager: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        print("[BLEManager] Bluetooth state: \(central.state.rawValue)")
        
        if central.state == .poweredOn {
            restartScan()
        }
    }
    
    func centralManager(_ central: CBCentralManager,
                        didConnect peripheral: CBPeripheral) {
        isConnected = true
        print("[BLEManager] Connected to '\(peripheral.name ?? "unknown")'")
        peripheral.discoverServices([serviceUUID])
    }

    func centralManager(_ central: CBCentralManager,
                        didFailToConnect peripheral: CBPeripheral, error: Error?) {
        isConnected = false
        connectError = error?.localizedDescription ?? "unknown problem"
        print("[BLEManager] Connection failed: \(connectError!)")
    }
    
    func centralManager(_ central: CBCentralManager,
                        didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        isConnected = false
        connectedPeripheral = nil
        writeCharacteristic = nil
        statusCharacteristic = nil
        print("[BLEManager] Disconnecting, restarting scan...")
        restartScan()
    }
    
    func sendWiFiCredentials(ssid: String, password: String) {
        guard let peripheral = connectedPeripheral,
              let characteristic = writeCharacteristic else {
            print("[BLEManager] No connected device.")
            return
        }
        let payload = "\(ssid);\(password)"
        guard let data = payload.data(using: .utf8) else { return }
        print("[BLEManager] Wi-Fi credentials sent: \(payload)")
        peripheral.writeValue(data, for: characteristic, type: .withResponse)
    }
}

extension BLEManager: CBPeripheralDelegate {
    func peripheral(_ peripheral: CBPeripheral,
                    didDiscoverServices error: Error?) {
        if let e = error {
            print("[BLEManager] Error at services: \(e.localizedDescription)")
            return
        }
        guard let services = peripheral.services else { return }
        for service in services {
            print("[BLEManager] Service found: \(service.uuid.uuidString)")
            peripheral.discoverCharacteristics([writeUUID, statusUUID], for: service)
        }
    }
}
