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
                
                // Subtitle
                Text("Zorg ervoor dat je in de buurt bent van je apparaat en dat het apparaat is ingeschakeld en adverteert via Bluetooth.")
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                    .padding(.horizontal, 24)
                
                // ProgressView
                if bleManager.peripherals.isEmpty {
                    VStack(spacing: 8) {
                        ProgressView()
                        Text("Bezig met scannen…")
                            .foregroundColor(.secondary)
                    }
                    .padding(.top, 50)
                } else { // Device peripherals
                    ScrollView {
                        VStack(spacing: 12) {
                            ForEach(bleManager.peripherals, id: \.identifier) { peripheral in
                                Button(action: {
                                    if selectedPeripheral?.identifier == peripheral.identifier {
                                        selectedPeripheral = nil
                                        print("[DeviceScanView] Deselected \(peripheral.name ?? "")")
                                    } else {
                                        selectedPeripheral = peripheral
                                        print("[DeviceScanView] Selected \(peripheral.name ?? "")")
                                    }
                                }) {
                                HStack {
                                    Text(peripheral.name ?? "TM_…")
                                        .font(.body)
                                        .bold()
                                        .foregroundColor(
                                            selectedPeripheral?.identifier == peripheral.identifier
                                                ? .white
                                                : .primary
                                        )
                                    Spacer()
                                    if selectedPeripheral?.identifier == peripheral.identifier {
                                        Image(systemName: "checkmark")
                                            .foregroundColor(.white)
                                    }
                                }
                                .padding(.horizontal, 16)
                                .frame(height: 50)
                                .background(
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 25)
                                            .fill(
                                                selectedPeripheral?.identifier == peripheral.identifier
                                                    ? Color.accentGreen
                                                    : Color.clear
                                            )
                                        RoundedRectangle(cornerRadius: 25)
                                            .stroke(Color.accentGreen, lineWidth: 2)
                                    }
                                )
                            }
                            .buttonStyle(PlainButtonStyle())
                            .padding(.horizontal, 24)
                        }
                    }
                    .padding(.vertical, 8)
                        
                    }
                }
                Spacer()
                
                Button(action: {
                    if let per = selectedPeripheral {
                        print("[DeviceScanView] connect(to: \(per.name ?? ""))")
                        bleManager.connect(to: per)
                        goToProvision = true
                    }
                }) {
                    Text("Verbind wifi")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(
                            (selectedPeripheral == nil)
                                ? Color.gray.opacity(0.5)
                                : Color.accentGreen
                        )
                        .foregroundColor(.white)
                        .cornerRadius(25)
                        .padding(.horizontal, 24)
                }
                .disabled(selectedPeripheral == nil)

                Spacer().frame(height: 16)
            }
        }
    }
}
