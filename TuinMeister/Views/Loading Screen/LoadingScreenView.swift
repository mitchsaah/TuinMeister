import SwiftUI

struct LoadingScreenView: View {
    static let accentGreen = Color(hex: 0x00C853)
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            Image("tm-logo")
                .resizable()
                .scaledToFit()
                .frame(width: 160, height: 160)

            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: Self.accentGreen))
                .scaleEffect(1.5)
            Spacer()
        }
        .background(Color.white.ignoresSafeArea())
    }
}
