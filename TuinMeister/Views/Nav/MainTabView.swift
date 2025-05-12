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
        
        let normal = appearance.stackedLayoutAppearance.normal
        normal.iconColor = .label
        normal.titleTextAttributes = [.foregroundColor: UIColor.label]
    
        let selected = appearance.stackedLayoutAppearance.selected
        selected.iconColor = UIColor(accentGreen)
        selected.titleTextAttributes = [.foregroundColor: UIColor(accentGreen)]

        UITabBar.appearance().standardAppearance = appearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = appearance
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
