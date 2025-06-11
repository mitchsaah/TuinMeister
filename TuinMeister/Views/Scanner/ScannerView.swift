import SwiftUI

struct ScannerView: View {
    @StateObject private var cameraViewModel = CameraViewModel()
    @State private var showOverlay = false
    @State private var suggestion: Suggestion? = nil

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
        
        .onAppear {
            cameraViewModel.frameHandler = { image in
                print("Frame captured!")
                if let jpegData = image.jpegData(compressionQuality: 0.8) {
                    let base64 = jpegData.base64EncodedString()
                    identifyPlant(base64Image: base64)
                }
            }
        }
        
        .onChange(of: showOverlay) {
            print("showOverlay triggered")
        }
        .fullScreenCover(isPresented: $showOverlay) {
            Group {
                if let suggestion {
                    PlantOverlayView(suggestion: suggestion)
                        .environmentObject(ArchiveViewModel.shared)
                } else {
                    Text("Geen plant gevonden")
                }
            }
        }
    }
    
    func scanCurrentFrame() {
        cameraViewModel.captureCurrentFrame()
    }
    
    func identifyPlant(base64Image: String) {
        PlantIDService.shared.identifyPlant(from: base64Image) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let s):
                    print("Plant identified: \(s.plantName)")
                    self.suggestion = s
                    self.showOverlay = true
                case .failure(let error):
                    print("API Error: \(error.localizedDescription)")
                }
            }
        }
    }
}
