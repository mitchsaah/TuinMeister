import Foundation
import Combine

final class ArchiveViewModel: ObservableObject {
    static let shared = ArchiveViewModel()

    @Published private(set) var archived: [ArchivedPlant] = []
}
