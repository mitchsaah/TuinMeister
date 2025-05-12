import SwiftUI

struct ScannerView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Text("Scanner pagina")
                    .font(.title2)
                    .foregroundColor(.secondary)
                Spacer()
            }
            .navigationTitle("Scanner")
        }
    }
}

struct ScannerView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ScannerView()
                .preferredColorScheme(.light)
            ScannerView()
                .preferredColorScheme(.dark)
        }
    }
}
