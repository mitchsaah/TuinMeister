import SwiftUI

struct SurveyView1: View {
    @Environment(\.presentationMode) private var presentationMode

    private let accentGreen = Color(hex: 0x7FC241)

    var body: some View {
        VStack (spacing: 0){
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .foregroundColor(.primary)
                }
                .padding(.leading, 16)

                Spacer()

                // Step 1 - Text
                HStack(spacing: 0) {
                    Text("Stap ")
                        .font(.headline)
                        .foregroundColor(.primary)
                    Text("1")
                        .font(.headline)
                        .foregroundColor(accentGreen)
                    Text(" van 2")
                        .font(.headline)
                        .foregroundColor(.primary)
                }
                
                Spacer()

                // Dummy spacer (for centering text)
                Color.clear
                    .frame(width: 32, height: 32)
                    .padding(.trailing, 16)
            }
            .padding(.vertical, 12)
            .background(Color(UIColor.systemBackground))
        }
        .navigationBarBackButtonHidden(true)
    }
}
