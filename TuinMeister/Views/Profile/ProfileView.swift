import SwiftUI
import FirebaseAuth
import CoreLocation

struct ProfileView: View {
    @State private var selectedTab: Tab = .garden
    @State private var firstName = ""
    @State private var lastName  = ""
    
    @State private var location  = ""
    @StateObject private var locationManager = LocationManager()
    
    private let accentGreen = Color(hex: 0x7FC241)
    
    enum Tab: String, CaseIterable {
        case garden = "Mijn Tuin"
        case archive = "Groen Archief"
    }
    
    var body: some View {
        NavigationStack {
            
            // Profile img placeholder
            Circle()
                .fill(Color.gray.opacity(0.3))
                .frame(width: 120, height: 120)
                .overlay(
                    Image(systemName: "person.fill")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                )
                .padding(.top)
            
            // User's name + location
            VStack {
                Text("\(firstName) \(lastName)")
                    .font(.title2).fontWeight(.semibold)
                
                Text(location)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            // Tab selector
            HStack {
                ForEach(Tab.allCases, id: \.self) { tab in
                    VStack(spacing: 4) {
                        Button(tab.rawValue) { selectedTab = tab }
                            .font(.headline)
                            .foregroundColor(selectedTab == tab ? accentGreen : .primary)
                        Rectangle()
                            .fill(selectedTab == tab ? accentGreen : .clear)
                            .frame(height: 2)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .padding(.horizontal)

            .onAppear(perform: loadProfile)
            .onReceive(locationManager.$location.compactMap { $0 }) { loc in
                lookupPlacemark(from: loc) { pm in
                    if let pc = pm?.postalCode, let city = pm?.locality {
                        location = "\(pc) \(city)"
                    }
                }
            }
        }
    }
    
    private func loadProfile() {
        if let user = Auth.auth().currentUser {
            let parts = (user.displayName ?? "")
                .split(separator: " ")
                .map(String.init)
            firstName = parts.first ?? ""
            lastName  = parts.dropFirst().joined(separator: " ")
        }
    }
}

fileprivate func lookupPlacemark(
    from location: CLLocation,
    completion: @escaping (CLPlacemark?) -> Void
) {
    CLGeocoder().reverseGeocodeLocation(location) { places, _ in
        completion(places?.first)
    }
}
