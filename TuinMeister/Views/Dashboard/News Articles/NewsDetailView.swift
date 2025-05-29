import SwiftUI

struct NewsDetailView: View {
    let article: NewsArticle

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Title
                Text(article.title)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.top)
                
                // Image
                AsyncImage(url: URL(string: article.imageUrl)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                } placeholder: {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.gray.opacity(0.2))
                        .frame(height: 200)
                }
                
                // Source
                VStack(alignment: .leading, spacing: 4) {
                    Text("Bron")
                        .font(.subheadline)
                        .fontWeight(.semibold)

                    Text(article.source)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                // Full text
                Text(article.text)
                    .font(.body)
                    .foregroundColor(.primary)
            }
            .padding()
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
}
