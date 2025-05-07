import Foundation
import Combine
import FirebaseAuth
import FirebaseCore
import GoogleSignIn
import UIKit

final class AuthViewModel: ObservableObject {
  @Published var firstName = ""
  @Published var lastName = ""
  @Published var email = ""
  @Published var password = ""
  @Published var confirmPassword = ""
  @Published var isLogin = true
  @Published var errorMessage: String?
    
    func submit() {
      errorMessage = nil
      if isLogin {
        AuthService.shared.signIn(email: email, password: password) { error in
          if let e = error {
            DispatchQueue.main.async { self.errorMessage = e.localizedDescription }
          }
        }
      } else {
        // Validate inputs before sign-up
        guard !firstName.isEmpty else { errorMessage = "Vul je voornaam in."; return }
        guard !lastName.isEmpty else { errorMessage = "Vul je achternaam in."; return }
        guard !email.isEmpty else { errorMessage = "Vul je e‑mail in."; return }
        guard !password.isEmpty, password == confirmPassword else {
          errorMessage = "Wachtwoorden komen niet overeen."; return
        }
        AuthService.shared.signUp(email: email, password: password) { error in
          if let e = error {
            DispatchQueue.main.async { self.errorMessage = e.localizedDescription }
          }
        }
      }
    }
    
    // Google sign-in
    func googleSignIn() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        GIDSignIn.sharedInstance.configuration = GIDConfiguration(clientID: clientID)
        
        guard
            let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let rootVC = scene.windows.first?.rootViewController
        else { return }
        
        GIDSignIn.sharedInstance.signIn(withPresenting: rootVC) { result, error in
            if let error = error {
                DispatchQueue.main.async { self.errorMessage = error.localizedDescription }
                return
            }
            
            guard let user = result?.user else {
                DispatchQueue.main.async { self.errorMessage = "Kon Google‑gebruiker niet laden." }
                return
            }
            
            guard let idTokenObj = user.idToken else {
                DispatchQueue.main.async { self.errorMessage = "Kon idToken niet ophalen." }
                return
            }
            let idToken = idTokenObj.tokenString

            let accessToken = user.accessToken.tokenString

            AuthService.shared.signInWithGoogle(
                idToken:     idToken,
                accessToken: accessToken
            ) { err in
                if let err = err {
                    DispatchQueue.main.async { self.errorMessage = err.localizedDescription }
                }
            }
        }
    }
}
