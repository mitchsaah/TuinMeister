import SwiftUI

struct PlantOverlayView: View {
    let suggestion: Suggestion
    private let accentGreen = Color(hex: 0x7FC241)
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var archiveVM: ArchiveViewModel

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
                
                VStack(alignment: .leading, spacing: 6) {
                    Text("Beschrijving").bold()

                    let description = suggestion.plantDetails.wikiDescription?.value?.trimmingCharacters(in: .whitespacesAndNewlines)

                    if let desc = description, !desc.isEmpty {
                        Text(desc)
                    } else if let fallbackURL = suggestion.plantDetails.url {
                        Text("Meer info: \(fallbackURL)")
                            .foregroundColor(.blue)
                            .underline()
                            .onTapGesture {
                                if let url = URL(string: fallbackURL) {
                                    UIApplication.shared.open(url)
                                }
                            }
                    }
                }
            }
        }
        
        .safeAreaInset(edge: .bottom) {
            Button {
                let plant = ArchivedPlant(
                    id: suggestion.plantName,
                    name: suggestion.plantName,
                    family: suggestion.plantDetails.taxonomy?.family,
                    maintenance: mapMaintenance(suggestion.plantDetails.watering),
                    dateAdded: Date()
                )
                archiveVM.addToArchive(plant)
                dismiss()
            } label: {
                Text("Opslaan in archief")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, minHeight: 44)
                    .background(accentGreen)
                    .cornerRadius(22)
            }
            .padding(.horizontal)
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
