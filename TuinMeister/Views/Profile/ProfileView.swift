import SwiftUI
import FirebaseAuth
import CoreLocation

struct ProfileView: View {
    @State private var selectedTab: Tab = .garden
    @State private var firstName = ""
    @State private var lastName  = ""
    
    @State private var location  = ""
    @StateObject private var locationManager = LocationManager()
    @StateObject private var deviceVM = DeviceListViewModel()
    
    private let accentGreen = Color(hex: 0x7FC241)
    
    enum Tab: String, CaseIterable {
        case garden = "Mijn Tuin"
        case archive = "Groen Archief"
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 24){
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
                VStack(spacing: 8){
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
                
                // Content
                Group {
                    switch selectedTab {
                    case .garden:
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(deviceVM.devices) { device in
                                    NavigationLink(value: device) {
                                        DeviceCardView(device: device)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                            .padding(.horizontal)
                        }
                        .frame(height: 200)
                        .onAppear { deviceVM.fetchDevices() }
                        
                    case .archive:
                        // "Groen Archief" placeholder
                        Text("Saved plant cards here")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }
                .animation(.easeInOut, value: selectedTab)
                
                Spacer()
                
                
                .onAppear(perform: loadProfile)
                .onReceive(locationManager.$location.compactMap { $0 }) { loc in
                    lookupPlacemark(from: loc) { pm in
                        if let pc = pm?.postalCode, let city = pm?.locality {
                            location = "\(pc) \(city)"
                        }
                    }
                }
                .navigationDestination(for: Device.self) { device in
                    DeviceDetailView(device: device)
                        .navigationBarBackButtonHidden(true)
                        .navigationBarHidden(true)
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
