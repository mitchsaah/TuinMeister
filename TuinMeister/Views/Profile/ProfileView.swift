import SwiftUI
import FirebaseAuth

struct ProfileView: View {
    @State private var firstName = ""
    @State private var lastName  = ""
    
    var body: some View {
        NavigationStack {
            
            // Profile img placeholder
            Circle()
                .fill(Color.gray.opacity(0.3))
                .frame(width: 120, height: 120)
                .overlay(
                    Image(systemName: "person.fill")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                )
                .padding(.top)
            
            // User's name
            VStack {
                Text("\(firstName) \(lastName)")
                    .font(.title2).fontWeight(.semibold)
                
                Spacer()
            }
            .navigationTitle("Profiel")
            .onAppear(perform: loadProfile)
        }
    }
    
    private func loadProfile() {
        if let user = Auth.auth().currentUser {
            let parts = (user.displayName ?? "")
                .split(separator: " ")
                .map(String.init)
            firstName = parts.first ?? ""
            lastName  = parts.dropFirst().joined(separator: " ")
        }
    }
}
