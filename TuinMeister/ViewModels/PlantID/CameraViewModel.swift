import AVFoundation
import UIKit

class CameraViewModel: NSObject, ObservableObject {
    private let session = AVCaptureSession()
    private let output = AVCapturePhotoOutput()

    @Published var isReady = false
    var frameHandler: ((UIImage) -> Void)?

    override init() {
        super.init()
    }

    func getSession() -> AVCaptureSession {
        return session
    }
}
