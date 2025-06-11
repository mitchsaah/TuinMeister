import SwiftUI

struct ArchivedPlantDetailView: View {
    @Environment(\.dismiss) private var dismiss
    let plant: ArchivedPlant
    
    private let accentGreen = Color(hex: 0x7FC241)
    
    var body: some View {
        HStack {
            // Custom Nav
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .font(.title2)
                    .foregroundColor(.primary)
            }
            .frame(width: 44, height: 44)
            
            Spacer()
            
            Text(plant.name)
                .font(.headline)
                .foregroundColor(.primary)
            
            Spacer()
            
            Color.clear.frame(width: 44, height: 44)
        }
        .padding(.horizontal)
        .padding(.top, 8)
        
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Static image
                Image(systemName: "leaf")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundColor(accentGreen)
                    .frame(maxWidth: .infinity)
                    .padding(.top, 12)
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Familie")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text(plant.family ?? "Onbekend")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                    }
                    Spacer()
                    VStack {
                        Text("Toegevoegd op")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text(plant.dateAdded.formatted(date: .abbreviated, time: .omitted))
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                    }
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text("Onderhoud")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text(plant.maintenance ?? "–")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                    }
                }
            }
        }
    }
}
