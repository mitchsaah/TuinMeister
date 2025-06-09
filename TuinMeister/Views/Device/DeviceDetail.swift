import SwiftUI

struct DeviceDetailView: View {
    @Environment(\.dismiss) private var dismiss
    let device: Device
    private let accentGreen = Color(hex: 0x7FC241)
    
    @State private var typeText: String = ""
    
    private var typeFirstWord: String {
        typeText.split(separator: " ").first.map(String.init) ?? typeText
    }

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
            
            ScrollView {
                VStack(spacing: 24) {
                    if let url = URL(string: device.imageUrl), !device.imageUrl.isEmpty {
                        AsyncImage(url: url) { img in
                            img
                                .resizable()
                                .scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(maxWidth: .infinity, maxHeight: 200)
                        .cornerRadius(12)
                        .padding(.horizontal)
                        .padding(.top, 16)
                    } else {
                        Image(systemName: "leaf")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 90, height: 90)
                            .foregroundColor(accentGreen)
                            .padding(.top, 16)
                    }
                    
                    HStack {
                        // Device #
                        VStack(alignment: .leading, spacing: 4) {
                            Text("TM")
                                .font(.caption)
                                .foregroundColor(.secondary)

                            Text(device.deviceName)
                                .font(.subheadline).fontWeight(.semibold)
                                .foregroundColor(accentGreen)
                        }

                        Spacer()

                        // Type
                        VStack(spacing: 4) {
                            Text("Type")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Text(typeFirstWord)
                                .font(.subheadline).fontWeight(.semibold)
                                .foregroundColor(.primary)
                        }

                        Spacer()
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
}
