import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Text("Profiel pagina")
                    .font(.title2)
                    .foregroundColor(.secondary)
                Spacer()
            }
            .navigationTitle("Profiel")
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ProfileView()
                .preferredColorScheme(.light)
            ProfileView()
                .preferredColorScheme(.dark)
        }
    }
}
