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
        
        let ref = Firestore.firestore()
            .collection("users")
            .document(uid)
            .collection("devices")
            .document(deviceName)

        ref.setData(data, merge: true) { error in
            if let error = error {
                print("Fout bij opslaan in Firestore: \(error.localizedDescription)")
                completion(error)
            } else {
                print("Device data succesvol opgeslagen voor \(deviceName)")
                completion(nil)
            }
        }
    }
}
