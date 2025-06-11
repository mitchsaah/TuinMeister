import SwiftUI

struct PlantArchiveView: View {
  @EnvironmentObject var archiveVM: ArchiveViewModel

  var body: some View {
    ScrollView(.vertical, showsIndicators: false) {
      VStack(spacing: 16) {
        ForEach(archiveVM.archived) { plant in
          NavigationLink(value: plant) {
            ArchivedPlantCardView(plant: plant)
          }
          .buttonStyle(.plain)
        }
      }
      .padding(.vertical)
      .onAppear { archiveVM.fetchArchive() }
    }
  }
}
