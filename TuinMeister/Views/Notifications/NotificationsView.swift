import SwiftUI

struct NotificationsView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Text("Meldingen pagina")
                    .font(.title2)
                    .foregroundColor(.secondary)
                Spacer()
            }
            .navigationTitle("Meldingen")
        }
    }
}

struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NotificationsView()
                .preferredColorScheme(.light)
            NotificationsView()
                .preferredColorScheme(.dark)
        }
    }
}
