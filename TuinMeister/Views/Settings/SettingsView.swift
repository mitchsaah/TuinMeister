import SwiftUI
import FirebaseAuth

struct SettingsView: View {
    @State private var showingLogoutConfirmation = false

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("Instellingen")
                    .font(.title2)
                    .fontWeight(.semibold)
                Spacer()
            }
            .frame(height: 44)
            .padding(.horizontal)
            .padding(.top, 8)
            
            // Navigation to user settings
            NavigationLink {
                UserSettingsView()
            } label: {
                HStack {
                    Text("Gebruikersinstellingen")
                        .foregroundColor(.primary)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.secondary)
                }
                .padding()
            }
            .buttonStyle(.plain)
            
            Spacer()
            
            // Log out button
            Button(role: .destructive) {
                showingLogoutConfirmation = true
            } label: {
                Text("Uitloggen")
                    .frame(maxWidth: .infinity, minHeight: 44)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(22)
                    .padding(.horizontal)
            }
            .confirmationDialog(
                "Weet je zeker dat je wilt uitloggen?",
                isPresented: $showingLogoutConfirmation,
                titleVisibility: .visible
            ) {
                Button("Uitloggen", role: .destructive) {
                    try? Auth.auth().signOut()
                }
                Button("Annuleren", role: .cancel) { }
            }
            .padding(.bottom, 16)
        }
    }
}
