import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var appState: AppState
    
    var body: some View {
            content
                .animation(.easeInOut, value: appState.didFinishSetup)
        }

        @ViewBuilder
        private var content: some View {
            if appState.user == nil {
                AuthView()
            } else if appState.didFinishSetup == nil {
                LoadingScreenView()
            } else if appState.didFinishSetup == true {
                MainTabView()
            } else {
                ConnectionFlowView {
                    appState.didFinishSetup = true
                }
            }
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AppState.shared)
    }
}
