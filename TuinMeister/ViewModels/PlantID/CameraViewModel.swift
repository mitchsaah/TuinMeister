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
    
    func captureCurrentFrame() {
        let settings = AVCapturePhotoSettings()
        output.capturePhoto(with: settings, delegate: self)
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

extension CameraViewModel: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput,
                     didFinishProcessingPhoto photo: AVCapturePhoto,
                     error: Error?) {
        guard let data = photo.fileDataRepresentation(),
              let image = UIImage(data: data) else {
            print("Failed to convert photo to image")
            return
        }

        DispatchQueue.main.async {
            self.frameHandler?(image)
        }
    }
}
