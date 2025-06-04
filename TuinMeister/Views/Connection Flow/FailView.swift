import SwiftUI

struct FailView: View {
    let deviceName: String
    
    @Environment(\.colorScheme) var colorScheme
    
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
        }
    }
    
    private var shadowColor: Color {
        colorScheme == .light
            ? Color.black.opacity(0.2)
            : Color.white.opacity(0.4)
    }
}
