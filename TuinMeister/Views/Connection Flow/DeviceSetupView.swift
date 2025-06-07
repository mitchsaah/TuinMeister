import SwiftUI

struct DeviceSetupView: View {    
    private let accentGreen = Color(hex: 0x89D152)
    
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
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(UIColor.systemBackground).edgesIgnoringSafeArea(.all))
        .navigationBarBackButtonHidden(true)
    }
}
