import Foundation
import CoreLocation
import Alamofire

class WeatherViewModel: ObservableObject {
    @Published var temperature: Int = 0
    @Published var humidity: Int = 0
    @Published var uvIndex: Int = 0
    
    private let apiKey: String = {
           return Bundle.main.object(forInfoDictionaryKey: "OPENWEATHER_API_KEY") as? String ?? ""
       }()

       func fetchWeather(for location: CLLocation) {
           let lat = location.coordinate.latitude
           let lon = location.coordinate.longitude

           let url = "https://api.openweathermap.org/data/3.0/onecall?lat=\(lat)&lon=\(lon)&exclude=minutely,hourly,daily,alerts&units=metric&appid=\(apiKey)"
           
           AF.request(url).validate().responseDecodable(of: WeatherData.self) { response in
               switch response.result {
               case .success(let weather):
                   DispatchQueue.main.async {
                       self.temperature = Int(weather.currentTemp)
                       self.humidity = Int(weather.currentHumidity)
                       self.uvIndex = Int(weather.uvIndex)
                   }
               case .failure(let error):
                   print("Weather error: \(error.localizedDescription)")
               }
           }
       }
}
