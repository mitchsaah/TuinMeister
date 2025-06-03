import SwiftUI
import CoreBluetooth

struct WiFiProvisionView: View {
    var deviceName: String
    var shouldReset: Bool
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var ssid = ""
    @State private var password = ""

    var body: some View {
        VStack(spacing: 16) {
            
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
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
        }
    }
}
