import SwiftUI

struct DeviceConnectView: View {
    @Environment(\.colorScheme) private var colorScheme
    private let accentGreen = Color(hex: 0x89D152)
    
    var body: some View {
        VStack(spacing: 40) {
            // Logo branding
            ZStack {
                Circle()
                    .stroke(accentGreen, lineWidth: 2)
                    .frame(width: 200, height: 200)
                    .shadow(color: Color(UIColor { traits in
                        traits.userInterfaceStyle == .dark
                        ? UIColor.white.withAlphaComponent(0.2)
                        : UIColor.black.withAlphaComponent(0.2)
                    }), radius: 4)
                
                Image("tm-logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
            }
            .padding(.top, 60)
        }
    }
}
