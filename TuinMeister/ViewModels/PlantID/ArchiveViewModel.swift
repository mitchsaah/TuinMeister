import Foundation
import Combine
import FirebaseAuth
import FirebaseFirestore

final class ArchiveViewModel: ObservableObject {
    static let shared = ArchiveViewModel()

    @Published private(set) var archived: [ArchivedPlant] = []
    
    private let db = Firestore.firestore()
    private var uid: String? { Auth.auth().currentUser?.uid }
}
