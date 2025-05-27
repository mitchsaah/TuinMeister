import Foundation
import CoreLocation

class WeatherViewModel: ObservableObject {
    @Published var temperature: Int = 0
    @Published var humidity: Int = 0
    @Published var uvIndex: Int = 0
}
