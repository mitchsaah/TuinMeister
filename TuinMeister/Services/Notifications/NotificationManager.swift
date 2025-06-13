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
}
