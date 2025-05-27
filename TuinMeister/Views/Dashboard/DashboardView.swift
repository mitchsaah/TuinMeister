import SwiftUI

struct DashboardView: View {
    @StateObject private var viewModel = WeatherViewModel()
    @StateObject private var locationManager = LocationManager()
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Text("Dashboard pagina")
                    .font(.title2)
                    .foregroundColor(.secondary)
                Spacer()
            }
            .navigationTitle("Dashboard")
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DashboardView()
                .preferredColorScheme(.light)
            DashboardView()
                .preferredColorScheme(.dark)
        }
    }
}
