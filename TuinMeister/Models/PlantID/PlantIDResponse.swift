import Foundation

struct PlantIDResponse: Codable {
    let suggestions: [Suggestion]
}

struct Suggestion: Codable {
    let plantName: String
}
