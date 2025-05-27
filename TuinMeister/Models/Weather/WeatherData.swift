struct WeatherData: Decodable {
    let currentTemp: Double
    let currentHumidity: Double
    let uvIndex: Double

    enum CodingKeys: String, CodingKey {
        case current
    }

    enum CurrentKeys: String, CodingKey {
        case temp, humidity, uvi
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let current = try container.nestedContainer(keyedBy: CurrentKeys.self, forKey: .current)

        currentTemp = try current.decode(Double.self, forKey: .temp)
        currentHumidity = try current.decode(Double.self, forKey: .humidity)
        uvIndex = try current.decode(Double.self, forKey: .uvi)
    }
}
