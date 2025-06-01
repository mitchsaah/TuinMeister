import AVFoundation
import UIKit

class CameraViewModel: NSObject, ObservableObject {
    private let session = AVCaptureSession()
    private let output = AVCapturePhotoOutput()

    @Published var isReady = false
    var frameHandler: ((UIImage) -> Void)?

    override init() {
        super.init()
        configureSession()
    }

    func getSession() -> AVCaptureSession {
        return session
    }
    
    private func configureSession() {
        session.beginConfiguration()
        session.sessionPreset = .photo

        guard let device = AVCaptureDevice.default(for: .video),
              let input = try? AVCaptureDeviceInput(device: device),
              session.canAddInput(input),
              session.canAddOutput(output) else {
            print("Failed to set up camera input/output")
            return
        }

        session.addInput(input)
        session.addOutput(output)

        session.commitConfiguration()
        session.startRunning()
        DispatchQueue.main.async {
            self.isReady = true
        }
    }
}
