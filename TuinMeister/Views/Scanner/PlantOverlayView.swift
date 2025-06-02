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
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Familie").bold()
                        Text(suggestion.plantDetails.taxonomy?.family ?? "Onbekend")
                    }
                    Spacer()
                    VStack(alignment: .leading) {
                        Text("Onderhoud").bold()
                        Text(mapMaintenance(suggestion.plantDetails.watering))
                    }
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
    
    func mapMaintenance(_ watering: Watering?) -> String {
            guard let watering = watering else { return "Onbekend" }
            let min = watering.min ?? 0
            let max = watering.max ?? 0
            let average = Double(min + max) / 2.0

            switch average {
            case 0..<1.5: return "Laag"
            case 1.5..<2.5: return "Gemiddeld"
            default: return "Hoog"
            }
        }

}
