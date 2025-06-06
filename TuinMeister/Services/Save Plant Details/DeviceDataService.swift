import Foundation
import FirebaseFirestore
import FirebaseAuth

class DeviceDataService {
    static let shared = DeviceDataService()

    private init() {}
    
    func saveDeviceData(
            deviceName: String,
            plantName: String,
            customName: String,
            type: String,
            plantDate: Date,
            imageUrl: String,
            completion: @escaping (Error?) -> Void
    ) {}
}
