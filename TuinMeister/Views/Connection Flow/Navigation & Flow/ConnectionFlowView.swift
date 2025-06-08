import SwiftUI

struct ConnectionFlowView: View {
    @State private var path: [ConnectionStep] = []
    @StateObject private var bleManager = BLEManager()
    @State private var plantType: SurveyView1.PlantType? = nil

    var body: some View {
        NavigationStack(path: $path) {
            DeviceConnectView {
                path.append(.deviceScan)
            }
            .navigationDestination(for: ConnectionStep.self) { step in
                switch step {
                case .deviceScan:
                    DeviceScanView { name in
                        path.append(.wifiProvision(deviceName: name))
                    }
                    .environmentObject(bleManager)
                    .navigationBarBackButtonHidden(true)

                case .wifiProvision(let name):
                    WiFiProvisionView(
                        deviceName: name,
                        shouldReset: true,
                        onNext: { path.append(.loading(deviceName: name)) },
                        path: $path
                    )
                    .environmentObject(bleManager)

                case .loading(let name):
                    LoadingView(
                        deviceName: name,
                        onSuccess: { path.append(.success(deviceName: name)) },
                        onFail: { path.append(.fail(deviceName: name)) }
                    )
                    .environmentObject(bleManager)

                case .fail(let name):
                    FailView(deviceName: name, onRetry: {
                        path.append(.wifiProvision(deviceName: name))
                    })
                    .environmentObject(bleManager)

                case .success(let name):
                    SuccessView(deviceName: name, onNext: {
                        path.append(.survey1(deviceName: name))
                    })

                case .survey1(let name):
                    SurveyView1(deviceName: name, onNext: { type in
                        plantType = type
                        path.append(.survey2(deviceName: name, type: type))
                    },
                    path: $path)

                case .survey2(let name, let type):
                    SurveyView2(deviceName: name, selectedType: type, onComplete: {
                        path.append(.setup(deviceName: name))
                    },
                    path: $path)

                case .setup(let name):
                    DeviceSetupView(deviceName: name)
                }
            }
        }
    }
}
