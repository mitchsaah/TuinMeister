import Foundation

class PlantIDService {
    static let shared = PlantIDService()
    private init() {}

    private var apiKey: String {
        guard let key = Bundle.main.object(forInfoDictionaryKey: "PLANT_ID_API_KEY") as? String else {
            fatalError("PLANT_ID_API_KEY not found in Info file")
        }
        return key
    }
}
