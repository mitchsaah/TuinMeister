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
        
        let body: [String: Any] = [
                "api_key": apiKey,
                "images": [base64Image],
                "modifiers": ["crops_fast", "similar_images"],
                "plant_language": "en",
                "plant_details": [
                    "common_names",
                    "wiki_description",
                    "watering",
                    "sunlight",
                    "taxonomy",
                    "url",
                    "default_image"
                ]
            ]

            request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "Empty response", code: -1)))
                return
            }

            do {
                let decoded = try JSONDecoder().decode(PlantIDResponse.self, from: data)
                if let suggestion = decoded.suggestions.first {
                    completion(.success(suggestion))
                } else {
                    completion(.failure(NSError(domain: "No result", code: -2)))
                }
            } catch {
                print("Decoding error: \(error)")
                completion(.failure(error))
            }
        }.resume()
    }
}
