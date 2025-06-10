import SwiftUI

struct DeviceListView: View {
    @EnvironmentObject private var deviceVM: DeviceListViewModel

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(deviceVM.devices) { device in
                    DeviceCardView(device: device)
                }
            }
            .padding(.horizontal)
        }
        .frame(height: 200)
    }
}
