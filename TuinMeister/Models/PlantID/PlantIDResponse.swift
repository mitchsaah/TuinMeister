import Foundation

struct PlantIDResponse: Codable {
    let suggestions: [Suggestion]
}

struct Suggestion: Codable {
    let plantName: String
    let plantDetails: PlantDetails
}

struct PlantDetails: Codable {
}

struct Watering: Codable {
    let min: Int?
    let max: Int?
}

struct WikiDescription: Codable {
    let value: String?
}

struct Taxonomy: Codable {
    let family: String?
}
