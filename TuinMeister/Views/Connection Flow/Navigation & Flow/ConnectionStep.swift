enum ConnectionStep: Hashable {
    case deviceScan
    case wifiProvision(deviceName: String)
    case loading(deviceName: String)
    case success(deviceName: String)
    case fail(deviceName: String)
    case survey1(deviceName: String)
    case survey2(deviceName: String, type: SurveyView1.PlantType)
    case setup(deviceName: String)
}
