import SwiftUI

struct DeviceCardView: View {
    let device: Device
    @Environment(\.colorScheme) private var colorScheme
    private let accentGreen = Color(hex: 0x7FC241)
    
    var body: some View {
        VStack(spacing: 8) {
            if let url = URL(string: device.imageUrl), !device.imageUrl.isEmpty {
                AsyncImage(url: url) { img in
                    img
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 120, height: 120)
                .cornerRadius(8)
            } else {
                Image(systemName: "leaf")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .padding(.top, 16)
            }
        }
    }
}
