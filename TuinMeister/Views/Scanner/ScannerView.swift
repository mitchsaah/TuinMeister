import SwiftUI

struct ScannerView: View {
    @StateObject private var cameraViewModel = CameraViewModel()

    var body: some View {
        ZStack {
            if cameraViewModel.isReady {
                CameraPreviewView(session: cameraViewModel.getSession())
                    .ignoresSafeArea()
            } else {
                Text("Camera starten mislukt.")
            }
        }
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
