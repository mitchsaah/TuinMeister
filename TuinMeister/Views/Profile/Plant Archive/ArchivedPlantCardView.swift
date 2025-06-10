import SwiftUI

struct ArchivedPlantCardView: View {
    let plant: ArchivedPlant

    var body: some View {
        HStack(spacing: 12) {
            // Static image
            Image(systemName: "leaf")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .foregroundColor(.gray)
            
            // Text info
            VStack(alignment: .leading, spacing: 4) {
                Text(plant.name)
                    .font(.headline)
                HStack {
                    Text("Familie:")
                        .font(.caption).bold()
                    Text(plant.family ?? "Onbekend")
                        .font(.caption)
                }
                HStack {
                    Text("Onderhoud:")
                        .font(.caption).bold()
                    Text(plant.maintenance ?? "-")
                        .font(.caption)
                }
            }
            
            Spacer()
        }
    }
}
