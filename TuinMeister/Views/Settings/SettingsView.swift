import SwiftUI

struct SettingsView: View {

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("Instellingen")
                    .font(.title2)
                    .fontWeight(.semibold)
                Spacer()
            }
            .frame(height: 44)
            .padding(.horizontal)
            .padding(.top, 8)
        }
    }
}
