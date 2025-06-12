import Foundation
import FirebaseAuth
import FirebaseFirestore
import Combine

final class AppState: ObservableObject {
  static let shared = AppState()
    @Published var user: User? = Auth.auth().currentUser {
        didSet{
            print("[AppState] user changed →", user?.uid ?? "nil")
        }
    }
    @Published var didFinishSetup: Bool = false {
        didSet {
            print("[AppState] didFinishSetup →", didFinishSetup)
        }
    }
  private var handle: AuthStateDidChangeListenerHandle?

  private init() {
      handle = Auth.auth().addStateDidChangeListener { [weak self] _, user in
          guard let self = self else { return }
          self.user = user
          if let uid = user?.uid {
            self.fetchDeviceCount(for: uid)
          } else {
            self.didFinishSetup = false
                      }
    }
  }
  deinit {
    if let h = handle { Auth.auth().removeStateDidChangeListener(h) }
  }
    
    private func fetchDeviceCount(for uid: String) {
            let db = Firestore.firestore()
            db.collection("users")
              .document(uid)
              .collection("devices")
              .getDocuments { [weak self] snap, error in
                guard let self = self else { return }
                if let docs = snap?.documents, docs.count > 0 {
                    self.didFinishSetup = true
                } else {
                    self.didFinishSetup = false
                }
            }
        }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.user = nil
            self.didFinishSetup = false
        } catch {
            print("[AppState] Error when logging out: \(error.localizedDescription)")
        }
    }
}
