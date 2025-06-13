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
}
