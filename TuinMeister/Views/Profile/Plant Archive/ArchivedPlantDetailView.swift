import SwiftUI

struct ArchivedPlantDetailView: View {
    @Environment(\.dismiss) private var dismiss
    let plant: ArchivedPlant
    
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
    }
}
