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
    
    func identifyPlant(from base64Image: String, completion: @escaping (Result<Suggestion, Error>) -> Void) {
        let url = URL(string: "https://api.plant.id/v2/identify")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    }
}
