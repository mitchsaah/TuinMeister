import Foundation
import Combine

final class AuthViewModel: ObservableObject {
  @Published var firstName = ""
  @Published var lastName = ""
  @Published var email = ""
  @Published var password = ""
  @Published var confirmPassword = ""
  @Published var isLogin = true
  @Published var errorMessage: String?

}
