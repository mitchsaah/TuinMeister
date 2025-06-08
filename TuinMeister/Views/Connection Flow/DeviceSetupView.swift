import SwiftUI

struct DeviceSetupView: View {    
    private let accentGreen = Color(hex: 0x89D152)
    let deviceName: String
    var onFinish: () -> Void
    
    var body: some View {
        VStack(spacing: 40) {
            // Logo
            ZStack {
                Circle()
                    .stroke(accentGreen, lineWidth: 2)
                    .frame(width: 200, height: 200)

                Image("tm-logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
            }
            .padding(.top, 60)
            
            // Title with text
            VStack(spacing: 8) {
                Text("Registratie gelukt!")
                    .font(.title2.weight(.bold))
                    .foregroundColor(.primary)

                Text("Plaats de TuinMeister zo dicht mogelijk bij de plant voor nauwkeurige en betrouwbare metingen. Kies daarna of je er nog een toevoegt of doorgaat naar de homepagina.")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                    .padding(.horizontal, 30)
            }
            
            Spacer()
            
            VStack(spacing: 16) {
                Button("Overslaan") {
                    onFinish()
                }
                .font(.headline)
                .frame(maxWidth: .infinity, minHeight: 54)
                .background(accentGreen)
                .foregroundColor(.white)
                .cornerRadius(21)

                Button("Nog een toevoegen") {
                    // 
                }
                .font(.headline)
                .frame(maxWidth: .infinity, minHeight: 54)
                .foregroundColor(accentGreen)
                .overlay(
                    RoundedRectangle(cornerRadius: 21)
                    .stroke(accentGreen, lineWidth: 1)
                )
                .background(Color(UIColor.systemBackground))
                .cornerRadius(21)
            }
            .padding(.horizontal, 30)
            .padding(.bottom, 60)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(UIColor.systemBackground).edgesIgnoringSafeArea(.all))
        .navigationBarBackButtonHidden(true)
    }
}
