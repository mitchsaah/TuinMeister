import Foundation
import FirebaseAuth
import GoogleSignIn

final class AuthService {
  static let shared = AuthService()
  private init() {}
}

extension AuthService {
  func signUp(email: String, password: String, completion: @escaping (Error?) -> Void) {
    Auth.auth().createUser(withEmail: email, password: password) { _, error in
      completion(error)
    }
  }
  
  func signIn(email: String, password: String, completion: @escaping (Error?) -> Void) {
    Auth.auth().signIn(withEmail: email, password: password) { _, error in
      completion(error)
    }
  }
    
    // Google sign-in
    func signInWithGoogle(idToken: String,
                          accessToken: String,
                          completion: @escaping (Error?) -> Void) {
        let credential = GoogleAuthProvider.credential(
            withIDToken: idToken,
            accessToken: accessToken
        )
        Auth.auth().signIn(with: credential) { _, error in
            completion(error)
        }
    }
  
  func signOut() {
    try? Auth.auth().signOut()
  }
}
