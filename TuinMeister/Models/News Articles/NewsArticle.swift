import Foundation

struct NewsArticle: Identifiable {
    let id: String
    let title: String
    let text: String
    let imageUrl: String
    let source: String
    let date: Date
}
