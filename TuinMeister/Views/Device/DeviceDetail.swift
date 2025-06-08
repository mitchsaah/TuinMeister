import SwiftUI

struct DeviceDetailView: View {
    @Environment(\.dismiss) private var dismiss
    let device: Device

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .foregroundColor(.primary)
                }
                .frame(width: 44, height: 44)

                Spacer()

                Text(device.customName)
                    .font(.headline)
                    .foregroundColor(.primary)

                Spacer()

                Color.clear.frame(width: 44, height: 44)
            }
            .padding(.horizontal)
            .padding(.top, 8)

            Spacer()
        }
    }
}
