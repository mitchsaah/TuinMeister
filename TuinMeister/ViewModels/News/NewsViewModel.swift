import Foundation
import FirebaseFirestore

class NewsViewModel: ObservableObject {
    @Published var articles: [NewsArticle] = []
    private var db = Firestore.firestore()
}
