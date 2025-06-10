import SwiftUI

struct ArchivedPlantCardView: View {
    let plant: ArchivedPlant

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "leaf")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .foregroundColor(.gray)
            
            Text(plant.name)
        }
    }
}
