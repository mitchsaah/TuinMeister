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
            
            Spacer()
            
            Text(device.customName)
                .font(.subheadline).fontWeight(.semibold)
                .foregroundColor(colorScheme == .dark ? .white : .black)
                .lineLimit(1)
            
            Text(device.deviceName)
                .font(.caption)
                .foregroundColor(accentGreen)
            
            Spacer(minLength: 8)
        }
        .frame(width: 140, height: 200)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
        )
    }
}
