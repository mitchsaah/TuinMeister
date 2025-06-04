import SwiftUI

struct SuccessView: View {
    let deviceName: String
    let onNext: () -> Void
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(spacing: 40) {
            Spacer()
            
            // Icon
            ZStack {
                Circle()
                    .fill(colorScheme == .light ? Color.white : Color.black)
                    .frame(width: 150, height: 150)
                    .shadow(
                        color: shadowColor,
                        radius: 10,
                        x: 0,
                        y: 0
                    )
                
                Image(systemName: "wifi")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(colorScheme == .light ? .blue : .accentGreen)
                    .frame(width: 70, height: 70)
            }
            
            // Success message
            VStack(spacing: 8) {
                Text("Gelukt!")
                    .font(.title)
                    .bold()
                Text("Jouw apparaat “\(deviceName)” is verbonden met jouw netwerk.")
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
