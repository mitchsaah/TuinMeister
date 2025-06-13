import Foundation
import FirebaseFirestore
import FirebaseAuth
import FirebaseDatabase

class NotificationManager: ObservableObject {
    @Published var notifications: [NotificationItem] = []

    private let db = Firestore.firestore()
    private let rtdb = Database.database(
        url: "https://tuinmeister-9352f-default-rtdb.europe-west1.firebasedatabase.app"
    ).reference()
    
    func startListening() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        db.collection("users")
            .document(uid)
            .collection("notifications")
            .order(by: "timestamp", descending: true)
            .addSnapshotListener { snapshot, _ in
                guard let docs = snapshot?.documents else { return }
                DispatchQueue.main.async {
                    self.notifications = docs.map {
                        NotificationItem(
                            id: $0.documentID,
                            message: $0["message"] as? String ?? "",
                            isRead: $0["isRead"] as? Bool ?? false,
                            customName: $0["custom_name"] as? String ?? "Je plant",
                            imageUrl: $0["imageUrl"] as? String ?? ""
                        )
                    }
                }
            }
    }
    
    func markAllAsRead() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let batch = db.batch()
        notifications.filter { !$0.isRead }.forEach { notif in
            let ref = db.collection("users")
                .document(uid)
                .collection("notifications")
                .document(notif.id)
            batch.updateData(["isRead": true], forDocument: ref)
        }
        batch.commit()
    }
    
    func checkAllDevicesForWaterAdvice() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        db.collection("users")
            .document(uid)
            .collection("devices")
            .getDocuments { snapshot, error in
                guard let docs = snapshot?.documents else { return }
                
                for doc in docs {
                    let data = doc.data()
                    let deviceName = doc.documentID
                    let customName = data["custom_name"] as? String ?? deviceName
                    let imageUrl = data["imageUrl"] as? String ?? ""
                    let plantName = data["plantName"] as? String ?? ""
                    
                    self.db.collection("plants").document(plantName).getDocument { snap, _ in
                        let careLevel = snap?.data()?["careLevel"] as? String ?? ""
                    }
                }
            }
    }
}
