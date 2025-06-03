import SwiftUI
import CoreBluetooth

struct WiFiProvisionView: View {
    var deviceName: String
    var shouldReset: Bool

    var body: some View {
        Text("Provisioning \(deviceName)…")
    }
}
