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
    
    func addToArchive(_ plant: ArchivedPlant) {
        guard let uid = uid else { return }
        let ref = db
            .collection("users")
            .document(uid)
            .collection("archive")
            .document(plant.id)
            
        do {
            try ref.setData(from: plant) { error in
                if let error = error {
                    print("Archive write failed:", error)
                } else {
                    DispatchQueue.main.async {
                        self.archived.append(plant)
                    }
                }
            }
        } catch {
            print("Failed to encode ArchivedPlant:", error)
        }
    }
}
