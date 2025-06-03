import SwiftUI
import CoreBluetooth

struct WiFiProvisionView: View {
    var deviceName: String
    var shouldReset: Bool
    
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(spacing: 16) {
            
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .foregroundColor(.gray)
                }
                .frame(width: 44, height: 44)
                
                Spacer()
                
                Text("Stel jouw wifi in")
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Spacer()
                
                Color.clear.frame(width: 44, height: 44)
            }
            .padding(.top, 8)
            .padding(.horizontal)
        }
    }
}
