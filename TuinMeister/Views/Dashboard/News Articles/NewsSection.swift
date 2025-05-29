import SwiftUI

struct NewsSection: View {
    @StateObject private var viewModel = NewsViewModel()
    @State private var showAll = false

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
        }
        .padding(.horizontal, 8)
        .onAppear {
            viewModel.fetchArticles()
        }
    }
}
