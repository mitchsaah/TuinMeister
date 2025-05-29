import SwiftUI

struct NewsSection: View {
    @StateObject private var viewModel = NewsViewModel()
    @State private var showAll = false

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Section title
            HStack(spacing: 0) {
                Text("Nieuws")
                    .font(.title2)
                    .fontWeight(.bold)
                Text(" Blad")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color(hex: 0x7FC241))
            }
            
            // Article list box
            VStack(spacing: 16) {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 16) {
                        ForEach(showAll ? viewModel.articles : Array(viewModel.articles.prefix(2))) { article in
                            NavigationLink(destination: NewsDetailView(article: article)) {
                                HStack(alignment: .center, spacing: 12) {
                                    AsyncImage(url: URL(string: article.imageUrl)) { image in
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                    } placeholder: {
                                        Color.gray.opacity(0.2)
                                    }
                                    .frame(width: 70, height: 70)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                }
                                .padding(.horizontal, 4)
                                .transition(.asymmetric(
                                    insertion: .move(edge: .bottom).combined(with: .opacity),
                                    removal: .opacity
                                ))
                            }
                        }
                    }
                }
                .frame(height: showAll ? CGFloat(viewModel.articles.count * 90) : 180)
            }
        }
        .padding(.horizontal, 8)
        .onAppear {
            viewModel.fetchArticles()
        }
    }
}
