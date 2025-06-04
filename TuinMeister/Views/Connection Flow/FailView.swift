import SwiftUI

struct FailView: View {
    let deviceName: String
    
    @EnvironmentObject var bleManager: BLEManager
    @Environment(\.colorScheme) var colorScheme
    
    @State private var goToWiFiProvision = false

    var body: some View {
        VStack(spacing: 40) {
            Spacer()
            
            // Icon
            ZStack {
                Circle()
                    .fill(colorScheme == .light ? Color.white : Color.black)
                    .frame(width: 150, height: 150)
                    .shadow(color: shadowColor, radius: 10, x: 0, y: 0)
                
                Image(systemName: "xmark")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.red)
                    .frame(width: 50, height: 50)
            }
            
            // Fail message
            VStack(spacing: 8) {
                Text("Verbinden mislukt")
                    .font(.title)
                    .bold()
                Text("Je Wi-Fi gegevens lijken niet juist. Probeer opnieuw.")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                    .padding(.horizontal, 30)
            }
            
            Spacer()

            Button(action: {
                print("[FailView] Try again, going back to WiFiProvisionView")
                    bleManager.didProvision = false
                    bleManager.provisionError = nil
                    bleManager.connectError = nil
                    bleManager.restartScan()
                    goToWiFiProvision = true
                }) {
                    Text("Opnieuw proberen")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.accentGreen)
                        .foregroundColor(.white)
                        .cornerRadius(25)
                        .padding(.horizontal, 24)
                }
            
            Spacer().frame(height: 20)
            
        }
        .navigationBarBackButtonHidden(true)
        .padding(.top, 8)
        .navigationDestination(isPresented: $goToWiFiProvision) {
            WiFiProvisionView(deviceName: deviceName, shouldReset: true)
                .environmentObject(bleManager)
        }
    }
    
    private var shadowColor: Color {
        colorScheme == .light
            ? Color.black.opacity(0.2)
            : Color.white.opacity(0.4)
    }
}
