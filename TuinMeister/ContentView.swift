import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var appState: AppState
    
    var body: some View {
        Group {
            if appState.user == nil {
                AuthView()

            } else if !appState.didFinishSetup {
                LoadingScreenView()

            } else {
                MainTabView()
            }
        }
        .animation(.easeInOut, value: appState.didFinishSetup)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AppState.shared)
    }
}
