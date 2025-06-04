import SwiftUI

struct LoadingView: View {    
    let deviceName: String

    var body: some View {
        VStack(spacing: 24) {
            
            Spacer()
            
            ProgressView()
                .scaleEffect(1.5)
                

            Text("Bezig met verbinden met \(deviceName)...")
                .font(.headline)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
            
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
    }
}
