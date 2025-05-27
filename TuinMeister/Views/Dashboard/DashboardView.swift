import SwiftUI

struct DashboardView: View {
    @StateObject private var viewModel = WeatherViewModel()
    @StateObject private var locationManager = LocationManager()
    
    var body: some View {
        NavigationStack {
            VStack (alignment: .leading, spacing: 16) {
                
                // Top nav + logo
                HStack {
                    Image(systemName: "line.3.horizontal")
                        .font(.title2)
                    Spacer()
                    Image("tm-logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 30)
                }
                .padding(.horizontal, 16)
                .padding(.top)
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
