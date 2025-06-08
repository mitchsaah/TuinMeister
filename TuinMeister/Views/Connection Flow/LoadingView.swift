import SwiftUI

struct LoadingView: View {    
    let deviceName: String
    var onSuccess: () -> Void
    var onFail: () -> Void
    
    @EnvironmentObject var bleManager: BLEManager

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
        
        // When BLE says OK => SuccessView
        .onReceive(bleManager.$didProvision) { didProv in
            if didProv {
                print("[LoadingView] BLEManager.didProvision == true → navigate to SuccessView")
                onSuccess()
            }
        }

        // When BLE sends error => FailView
        .onReceive(bleManager.$provisionError) { err in
            if let errorMsg = err, !errorMsg.isEmpty {
                print("[LoadingView] BLEManager.provisionError received → navigate to FailView")
                onFail()
            }
        }
    }
}
