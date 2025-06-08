import Foundation
import FirebaseAuth
import FirebaseFirestore

final class DeviceListViewModel: ObservableObject {
    @Published var devices: [Device] = []

    func fetchDevices() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Firestore.firestore()
            .collection("users")
            .document(uid)
            .collection("devices")
            .getDocuments { snapshot, error in
                if let docs = snapshot?.documents {
                    self.devices = docs.map { doc in
                        let data = doc.data()
                        return Device(
                            id: doc.documentID,
                            customName: data["custom_name"] as? String ?? "",
                            imageUrl:   data["imageUrl"]   as? String ?? "",
                            deviceName: doc.documentID
                        )
                    }
                print("Loaded \(self.devices.count) devices")
                } else {
                    print("Failed loading devices:", error?.localizedDescription ?? "")
                }
        }
    }
}
