import Foundation
import FirebaseFirestore

class NewsViewModel: ObservableObject {
    @Published var articles: [NewsArticle] = []
    private var db = Firestore.firestore()
    
    func fetchArticles() {
        db.collection("articles")
            .order(by: "date", descending: true)
            .limit(to: 4)
            .addSnapshotListener { snapshot, error in
                if let error = error {
                    print(" Error fetching articles: \(error.localizedDescription)")
                    return
                }

                guard let documents = snapshot?.documents else {
                    print("No documents found")
                    return
                }

            }
    }
}
