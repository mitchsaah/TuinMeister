import SwiftUI
import FirebaseAuth

struct UserSettingsView: View {
  @Environment(\.dismiss) private var dismiss
    
    @State private var displayName: String = ""
    private let accentGreen = Color(hex: 0x7FC241)

  var body: some View {
    VStack {
      HStack {
        Button { dismiss() } label: {
          Image(systemName: "chevron.left")
            .font(.title2)
            .foregroundColor(.primary)
        }
        .frame(width: 44, height: 44)

        Spacer()

        Text("Gebruikersinstellingen")
          .font(.headline)
          .frame(maxWidth: .infinity)

        Spacer()

        Color.clear.frame(width: 44, height: 44)
      }
      .padding(.horizontal)
      .padding(.top, 8)
        
        // Profile picture placeholder
        Circle()
            .fill(Color.gray.opacity(0.3))
            .frame(width: 120, height: 120)
            .overlay(
                Image(systemName: "person.fill")
                    .font(.largeTitle)
                    .foregroundColor(.white)
            )
        
        // Name input field
        VStack(alignment: .leading, spacing: 4) {
            Text("Naam")
                .font(.caption).fontWeight(.semibold)
                .padding(.vertical, 8)
            
            TextField("Voornaam Achternaam", text: $displayName)
                .padding(.vertical, 12)
                .padding(.horizontal, 16)
                .background(
                    RoundedRectangle(cornerRadius: 50)
                        .stroke(accentGreen, lineWidth: 1)
                )
        }
        .padding(.horizontal)


      Spacer()
    // Save user settings-button
        Button(action: saveProfile) {
            Text("Instellingen opslaan")
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, minHeight: 50)
                .background(accentGreen)
                .cornerRadius(25)
                .padding(.horizontal)
        }
        .padding(.bottom, 16)
    }
    .navigationBarBackButtonHidden(true)
    .onAppear(perform: loadProfile)
  }
    private func loadProfile() {
        if let user = Auth.auth().currentUser {
            displayName = user.displayName ?? ""
        }
    }
    
    private func saveProfile() {
        guard !displayName.isEmpty else { return }
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = displayName
        changeRequest?.commitChanges { _ in
            dismiss()
        }
    }
}
