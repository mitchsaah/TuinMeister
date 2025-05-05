import Foundation
import FirebaseAuth
import Combine

final class AppState: ObservableObject {
  static let shared = AppState()
  @Published var user: User? = Auth.auth().currentUser
  private var handle: AuthStateDidChangeListenerHandle?

  private init() {
    handle = Auth.auth().addStateDidChangeListener { _, user in
      self.user = user
    }
  }
  deinit {
    if let h = handle { Auth.auth().removeStateDidChangeListener(h) }
  }
}
