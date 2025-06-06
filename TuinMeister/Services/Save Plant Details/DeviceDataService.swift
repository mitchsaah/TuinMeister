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
    ) {
        guard let uid = Auth.auth().currentUser?.uid else {
            let error = NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey: "Gebruiker niet ingelogd"])
            completion(error)
            return
        }
        
        let data: [String: Any] = [
            "plantName": plantName,
            "custom_name": customName,
            "type": type,
            "plantDate": Timestamp(date: plantDate),
            "imageUrl": imageUrl
        ]
    }
}
