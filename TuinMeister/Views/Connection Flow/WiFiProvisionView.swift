import SwiftUI
import CoreBluetooth

struct WiFiProvisionView: View {
    var deviceName: String
    var shouldReset: Bool
    var onNext: () -> Void
    @State private var bleReadyTrigger = false
    
    @Binding var path: [ConnectionStep]
    
    @EnvironmentObject var bleManager: BLEManager
    
    @State private var ssid = ""
    @State private var password = ""

    var body: some View {
        VStack(spacing: 16) {
            
            HStack {
                Button(action: {
                    path.removeLast()
                }) {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .foregroundColor(.gray)
                }
                .frame(width: 44, height: 44)
                
                Spacer()
                
                Text("Stel jouw wifi in")
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Spacer()
                
                Color.clear.frame(width: 44, height: 44)
            }
            .padding(.top, 8)
            .padding(.horizontal)
            
            // Introduction text
            Text("Vul hieronder je Wi-Fi-gegevens in voor apparaat “\(deviceName)”.")
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .padding(.horizontal, 24)
            
            // Input fields
            TextField("Wi-Fi naam (SSID)", text: $ssid)
                .padding(.horizontal, 16)
                .frame(height: 50)
                .background(RoundedRectangle(cornerRadius: 25).fill(Color(UIColor.systemBackground)))
                .overlay(RoundedRectangle(cornerRadius: 25).stroke(Color.accentGreen, lineWidth: 2))
                .padding(.horizontal, 24)
                .autocapitalization(.none)
                .disableAutocorrection(true)

            SecureField("Wachtwoord", text: $password)
                .padding(.horizontal, 16)
                .frame(height: 50)
                .background(RoundedRectangle(cornerRadius: 25).fill(Color(UIColor.systemBackground)))
                .overlay(RoundedRectangle(cornerRadius: 25).stroke(Color.accentGreen, lineWidth: 2))
                .padding(.horizontal, 24)
                .autocapitalization(.none)
                .disableAutocorrection(true)

            Spacer()
            
            // Connect to wifi button
            Button(action: {
                print("[WiFiProvisionView] Start provisioning with '\(ssid)' / '\(password)'")
                bleManager.sendWiFiCredentials(ssid: ssid, password: password)
                onNext()
            }) {
                Text("Verbind wifi")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(shouldEnableButton ? Color.accentGreen : Color.gray.opacity(0.5))
                    .foregroundColor(.white)
                    .cornerRadius(25)
                    .padding(.horizontal, 24)
            }
            .disabled(!shouldEnableButton)
            
            Spacer().frame(height: 16)
        }
        
        .navigationBarBackButtonHidden(true)
            .onAppear {
                print("[WiFiProvisionView] isConnected: \(bleManager.isConnected), isReadyToWrite: \(bleManager.isReadyToWrite)")
                if shouldReset {
                    ssid = ""
                    password = ""
            }
            if !bleManager.isConnected,
                let p = bleManager.peripherals.first(where: { $0.name == deviceName }) {
                bleManager.connect(to: p)
            }
        }
    }
    
    private var shouldEnableButton: Bool {
        !ssid.isEmpty && !password.isEmpty && bleManager.isConnected && bleManager.isReadyToWrite
    }
}
