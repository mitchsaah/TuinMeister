import SwiftUI

struct ScannerView: View {
    @StateObject private var cameraViewModel = CameraViewModel()

    var body: some View {
        ZStack {
            if cameraViewModel.isReady {
                CameraPreviewView(session: cameraViewModel.getSession())
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    Button(action: {
                        print("Button tapped")
                        scanCurrentFrame()
                    }) {
                        Text("Scan Plant")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(.ultraThinMaterial)
                            .clipShape(Capsule())
                    }
                    .padding()
                }
            } else {
                Text("Camera starten mislukt.")
            }
        }
    }
    
    func scanCurrentFrame() {
        cameraViewModel.captureCurrentFrame()
    }
}

struct ScannerView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ScannerView()
                .preferredColorScheme(.light)
            ScannerView()
                .preferredColorScheme(.dark)
        }
    }
}
