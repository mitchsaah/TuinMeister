import Foundation
import FirebaseFirestore
import Combine

class PlantSearchViewModel: ObservableObject {
    @Published var allPlants: [PlantModel] = []
    @Published var searchText: String = ""
    @Published var filteredPlants: [PlantModel] = []

    private var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchPlants()
        
        $searchText
            .debounce(for: .milliseconds(200), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] text in
                self?.filterPlants(with: text)
            }
            .store(in: &cancellables)
    }
    
    func fetchPlants() {
        Firestore.firestore().collection("plants").getDocuments { snapshot, error in
            if let error = error {
                print("Firestore error: \(error.localizedDescription)")
                return
            }

            guard let documents = snapshot?.documents else {
                    return
            }

            print("Retrieved \(documents.count) plant(s) from Firestore")

            self.allPlants = documents.compactMap { doc in
                let data = doc.data()
                let plantName = data["name"] as? String ?? "Name missing"
                print("→ Plant found: \(plantName)")

                return PlantModel(
                    id: doc.documentID,
                    name: plantName,
                    imageUrl: data["imageUrl"] as? String,
                    type: data["type"] as? String ?? "unknown",
                    description: data["description"] as? String
                )
            }

            self.filterPlants(with: self.searchText)
        }
    }

    func filterPlants(with text: String) {
        if text.isEmpty {
            filteredPlants = []
        } else {
            let matches = allPlants.filter {
                $0.name.lowercased().contains(text.lowercased())
            }
            filteredPlants = matches
            print("\(matches.count) match(es) for '\(text)'")
            for match in matches {
                    print("\(match.name)")
            }
        }
    }
}
