import Foundation

struct PlantIDResponse: Codable {
    let suggestions: [Suggestion]
}

struct Suggestion: Codable {
    let plantName: String
    let plantDetails: PlantDetails
}

struct PlantDetails: Codable {
    let watering: Watering?
    let wikiDescription: WikiDescription?
    let taxonomy: Taxonomy?
    let defaultImage: PlantImage?
    let url: String?
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

struct PlantImage: Codable {
    let url: String?
}
