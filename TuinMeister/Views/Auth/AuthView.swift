import SwiftUI
import FirebaseAuth

// Branding color shortcuts
private let backgroundGray = Color(hex: 0xE0E0E0)  // #E0E0E0
private let accentGreen    = Color(hex: 0x89D152)  // #89D152

struct AuthView: View {
    @ObservedObject private var vm = AuthViewModel()

    var body: some View {
        ZStack {
            backgroundGray.ignoresSafeArea()

            VStack(spacing: 24) {
                // Logo
                Image("tm-logo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 150)
                    .padding(.top, 40)

                // Tagline
                (
                    Text("Slimme zorg. ")
                        .font(.custom("Poppins-Bold", size: 24))
                        .foregroundColor(.black)
                    +
                    Text("Groene pracht.")
                        .font(Font.custom("Poppins-Bold", size: 24))
                        .foregroundColor(accentGreen)
                )

                // Section title
                Text(vm.isLogin ? "Inloggen" : "Registreren")
                    .font(.custom("Poppins-SemiBold", size: 20))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)

                // Form fields
                VStack(spacing: 16) {
                    // E-mail field with visible placeholder
                    ZStack(alignment: .leading) {
                        if vm.email.isEmpty {
                            Text("E-mail")
                                .foregroundColor(.gray)
                                .padding(.leading, 16)
                        }
                        TextField("", text: $vm.email)
                            .foregroundColor(.black)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .padding(12)
                    }
                    .background(Color.clear)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                    )
                    .padding(.horizontal)

                    // Password field with visible placeholder
                    ZStack(alignment: .leading) {
                        if vm.password.isEmpty {
                            Text("Wachtwoord")
                                .foregroundColor(.gray)
                                .padding(.leading, 16)
                        }
                        SecureField("", text: $vm.password)
                            .foregroundColor(.black)
                            .padding(12)
                    }
                    .background(Color.clear)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                    )
                    .padding(.horizontal)

                    // Confirm password (registration only)
                    if !vm.isLogin {
                        ZStack(alignment: .leading) {
                            if vm.confirmPassword.isEmpty {
                                Text("Bevestig wachtwoord")
                                    .foregroundColor(.gray)
                                    .padding(.leading, 16)
                            }
                            SecureField("", text: $vm.confirmPassword)
                                .foregroundColor(.black)
                                .padding(12)
                        }
                        .background(Color.clear)
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                        )
                        .padding(.horizontal)
                    }

                    // Error message
                    if let msg = vm.errorMessage {
                        Text(msg)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }

                    // Submit button
                    Button(action: vm.submit) {
                        Text(vm.isLogin ? "Log in" : "Maak account")
                            .frame(maxWidth: .infinity)
                            .padding(12)
                            .background(accentGreen)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .padding(.horizontal)
                    
                    HStack(alignment: .center) {
                        Rectangle()
                            .fill(Color.black)
                            .frame(height: 1)
                        
                        // Other options text
                        Text("Of ga verder met")
                            .font(.footnote)
                            .foregroundColor(.black)
                            .padding(.horizontal, 8)
                            .fixedSize()
                        
                        Rectangle()
                            .fill(Color.black)
                            .frame(height: 1)
                    }
                    .padding(.horizontal)
                    .padding(.top, 40)
                    
                    // Google and Facebook buttons
                    HStack(spacing: 16) {
                        // Google button
                      Button(action: vm.googleSignIn) {
                        Image("google-icon")
                          .resizable()
                          .scaledToFit()
                          .frame(width: 24, height: 24)
                      }
                      .frame(maxWidth: .infinity)
                      .frame(height: 54)
                      .overlay(
                        RoundedRectangle(cornerRadius: 8)
                          .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                      )

                      // Facebook button
                        Button(action: vm.facebookSignIn) {
                            Image("facebook-icon")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 54)
                        .overlay(
                          RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                        )
                    }
                    .padding(.horizontal)

                    Spacer()

                    // Footer toggle link
                    Button(action: {
                        vm.isLogin.toggle()
                        vm.errorMessage = nil
                    }) {
                        Text(vm.isLogin
                              ? "Nog geen account? "
                              : "Heb je al een account? ")
                            .foregroundColor(.black)
                        + Text(vm.isLogin
                              ? "Registreer hier!"
                              : "Inloggen")
                            .foregroundColor(accentGreen)
                    }
                    .font(.footnote)
                }
            }
        }
    }
}
