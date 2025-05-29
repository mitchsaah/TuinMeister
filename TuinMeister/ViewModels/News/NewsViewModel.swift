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
                
                self.articles = documents.compactMap { doc in
                    let data = doc.data()

                    guard
                        let title = data["title"] as? String,
                        let text = data["text"] as? String,
                        let imageUrl = data["imageUrl"] as? String,
                        let source = data["source"] as? String,
                        let timestamp = data["date"] as? Timestamp
                    else {
                        print("Failed to decode an article")
                        return nil
                    }

                    return NewsArticle(
                        id: doc.documentID,
                        title: title,
                        text: text,
                        imageUrl: imageUrl,
                        source: source,
                        date: timestamp.dateValue()
                    )
                }
            }
    }
}
