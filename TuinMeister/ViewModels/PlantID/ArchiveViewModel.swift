import Foundation
import Combine
import FirebaseAuth
import FirebaseFirestore

final class ArchiveViewModel: ObservableObject {
    static let shared = ArchiveViewModel()

    @Published private(set) var archived: [ArchivedPlant] = []
    
    private let db = Firestore.firestore()
    private var uid: String? { Auth.auth().currentUser?.uid }
    
    func fetchArchive() {
        guard let uid = uid else { return }
        db
            .collection("users")
            .document(uid)
            .collection("archive")
            .getDocuments { snapshot, error in
                guard let docs = snapshot?.documents else { return }
                self.archived = docs.compactMap { doc in
                    try? doc.data(as: ArchivedPlant.self)
                }
            }
    }
}
