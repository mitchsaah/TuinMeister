import Foundation

struct ArchivedPlant: Identifiable, Codable, Hashable {
  let id: String
  let name: String
  let family: String?
  let maintenance: String?
  let description: String?
  let fallbackURL: String?
  let dateAdded: Date
}
