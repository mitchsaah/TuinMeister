import SwiftUI
import CoreBluetooth

struct DeviceScanView: View {
    @StateObject private var bleManager = BLEManager()
    @State private var selectedPeripheral: CBPeripheral?
    @State private var goToProvision = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                
                HStack {
                    Button(action: {
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .foregroundColor(.gray)
                    }
                    .frame(width: 44, height: 44)
                    
                    Spacer()
                    
                    HStack(spacing: 0) {
                        Text("Zoeken naar ")
                            .font(.headline)
                            .foregroundColor(.primary)
                        Text("TuinMeister")
                            .font(.headline)
                            .foregroundColor(.accentGreen)
                    }
                    
                    Spacer()
                    Color.clear.frame(width: 44, height: 44)
                }
                .padding(.top, 8)
                .padding(.horizontal)
                
                Text("Zorg ervoor dat je in de buurt bent van je apparaat en dat het apparaat is ingeschakeld en adverteert via Bluetooth.")
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                    .padding(.horizontal, 24)
            }
        }
    }
}
