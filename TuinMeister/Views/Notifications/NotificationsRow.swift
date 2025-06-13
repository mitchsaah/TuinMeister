import SwiftUI



struct NotificationRow: View {
    let message: String
    let customName: String
    let imageUrl: String

    private let accentGreen = Color(hex: 0x7FC241)

    var body: some View {
        HStack(alignment: .center, spacing: 32) {
            ZStack {
                // Plant image
                Circle()
                    .strokeBorder(Color.primary.opacity(0.2), lineWidth: 1)
                    .frame(width: 60, height: 60)
                
                if let url = URL(string: imageUrl), !imageUrl.isEmpty {
                    AsyncImage(url: url) { img in
                        img.resizable()
                    } placeholder: {
                        Image(systemName: "leaf")
                            .resizable()
                    }
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                } else {
                    Image(systemName: "leaf")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                        .foregroundColor(accentGreen)
                }
            }
        }
    }
}
