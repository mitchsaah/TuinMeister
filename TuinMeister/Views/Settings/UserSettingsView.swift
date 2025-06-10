import SwiftUI

struct UserSettingsView: View {
  @Environment(\.dismiss) private var dismiss

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

      Spacer()
      // Placeholder content
      Text("Dit is de gebruikersinstellingen-pagina")
        .foregroundColor(.secondary)
      Spacer()
    }
    .navigationBarBackButtonHidden(true)
  }
}
