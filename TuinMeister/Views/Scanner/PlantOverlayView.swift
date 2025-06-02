import SwiftUI

struct PlantOverlayView: View {
    let suggestion: Suggestion
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                VStack(alignment: .center, spacing: 16) {
                    HStack {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "chevron.left")
                                .font(.title2)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                    }

                    Text(suggestion.plantName)
                        .font(.title2)
                        .bold()
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
                }
                
                if let url = getPlantImageURL() {
                    AsyncImage(url: url) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .scaledToFill()
                    .frame(height: 250)
                    .clipped()
                    .cornerRadius(16)
                }
            }
            .padding()
        }
    }
    
    func getPlantImageURL() -> URL? {
        if let similar = suggestion.similarImages?.first?.url,
            let url = URL(string: similar) {
            return url
        }
        if let fallback = suggestion.plantDetails.defaultImage?.url,
            let url = URL(string: fallback) {
            return url
        }
        return nil
    }
}
