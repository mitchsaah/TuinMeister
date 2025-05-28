import SwiftUI
import CoreLocation

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
                
                // Title
                HStack(spacing: 0) {
                    Text("Mijn")
                        .font(.system(size: 28, weight: .semibold))
                        .foregroundColor(Color.primary)
                    Text(" Tuin")
                        .font(.system(size: 28, weight: .semibold))
                        .foregroundColor(Color(hex: 0x7FC241))
                }
                .padding(.horizontal, 16)
                
                // Weather info boxes
                HStack(spacing: 16) {
                    WeatherBox(icon: "thermometer", value: "\(viewModel.temperature)°")
                    WeatherBox(icon: "drop", value: "\(viewModel.humidity)%")
                    WeatherBox(icon: "sun.max", value: "\(viewModel.uvIndex)")
                }
                .padding(.horizontal, 16)
                .frame(maxWidth: .infinity, alignment: .center)
                .frame(height: 70)

                Spacer()
            }
            .padding(.horizontal, 16)
            .onAppear {
                if let location = locationManager.location {
                    viewModel.fetchWeather(for: location)
                }
            }
            .onReceive(locationManager.$location.compactMap { $0 }) { location in
                viewModel.fetchWeather(for: location)
            }
            .navigationBarHidden(true)
        }
    }
}

struct WeatherBox: View {
    let icon: String
    let value: String

    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: icon)
            Text(value)
                .fontWeight(.medium)
        }
        .frame(maxWidth: .infinity, minHeight: 60)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .stroke(colorScheme == .dark ? Color.white : Color.black.opacity(0.2), lineWidth: 1)
        )
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
