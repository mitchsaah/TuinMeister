import SwiftUI

// Branding colors
private let accentGreen = Color(hex: 0x89D152)

struct MainTabView: View {
    init() {
           let appearance = UITabBarAppearance()
           appearance.configureWithOpaqueBackground()
        
            appearance.backgroundColor = UIColor {trait in
                trait.userInterfaceStyle == .dark ? .black : .white
            }
           }
    
    var body: some View {
        TabView {
            NotificationsView()
                .tabItem {
                    Image(systemName: "exclamationmark.triangle")
                    Text("Meldingen")
                }
            
            DashboardView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Dashboard")
                }
            
            ScannerView()
                .tabItem {
                    Image(systemName: "qrcode.viewfinder")
                    Text("Scanner")
                }
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Profiel")
                }
        }
    }
}
