import SwiftUI
import CoreBluetooth

struct DeviceScanView: View {
    @StateObject private var bleManager = BLEManager()
    @State private var selectedPeripheral: CBPeripheral?
    @State private var goToProvision = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                
                Spacer()
            }
        }
    }
}
