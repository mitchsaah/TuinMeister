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
        }
        .padding(.horizontal, 8)
        .onAppear {
            viewModel.fetchArticles()
        }
    }
}
