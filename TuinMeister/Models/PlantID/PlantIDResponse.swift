import Foundation

struct PlantIDResponse: Codable {
    let suggestions: [Suggestion]
}

struct Suggestion: Codable {
    let plantName: String
    let plantDetails: PlantDetails
    let probability: Double
    let similarImages: [SimilarImage]?

    enum CodingKeys: String, CodingKey {
        case plantName = "plant_name"
        case plantDetails = "plant_details"
        case probability
        case similarImages = "similar_images"
    }
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

struct SimilarImage: Codable {
    let id: String?
    let url: String?
    let similarity: Double?
}
