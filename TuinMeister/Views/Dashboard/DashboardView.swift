import SwiftUI
import CoreLocation

struct DashboardView: View {
    @StateObject private var viewModel = WeatherViewModel()
    @StateObject private var locationManager = LocationManager()
    @StateObject private var deviceVM = DeviceListViewModel() 
    @EnvironmentObject var archiveVM: ArchiveViewModel
    
    @State private var showingSettings = false
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack (alignment: .leading, spacing: 16) {
                
                // Top nav + logo
                HStack {
                    Button {
                        showingSettings = true
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .font(.title2)
                    }
                    .buttonStyle(.plain)
                    Spacer()
                    Image("tm-logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 30)
                }
                .padding(.horizontal, 8)
                .padding(.top)
                
                // Title
                HStack(spacing: 0) {
                    Text("Mijn")
                        .font(.system(size: 32, weight: .semibold))
                        .foregroundColor(Color.primary)
                    Text(" Tuin")
                        .font(.system(size: 32, weight: .semibold))
                        .foregroundColor(Color(hex: 0x7FC241))
                }
                .padding(.horizontal, 8)
                .padding(.bottom, 24)
                
                // Weather info boxes
                HStack(spacing: 8) {
                    WeatherBox(icon: "thermometer", value: "\(viewModel.temperature)°")
                    WeatherBox(icon: "drop", value: "\(viewModel.humidity)%")
                    WeatherBox(icon: "sun.max", value: "\(viewModel.uvIndex)")
                }
                .padding(.horizontal, 8)
                .padding(.bottom, 24)
                .frame(maxWidth: .infinity, alignment: .center)
                .frame(height: 50)
                
                // Instruction text
                Text("Hier kan je uw apparaten verbinden door het groene plusje aan te tikken.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.horizontal, 8)

                // Filter + add button row
                HStack(spacing: 8) {
                    HStack(spacing: 8) {
                        FilterButton(title: "Alle")
                        FilterButton(title: "Indoor")
                        FilterButton(title: "Outdoor")
                    }

                    Spacer()

                    Button(action: {
                    // Placeholder action
                    }) {
                        Image(systemName: "plus")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.white)
                            .frame(height: 40)
                            .padding(.horizontal, 8)
                            .background(Color(hex: 0x89D152))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                }
                .padding(.horizontal, 8)
                .padding(.bottom, 24)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(deviceVM.devices) { device in
                            NavigationLink(value: device) {
                                DeviceCardView(device: device)
                            }
                        }
                    }
                    .padding(.horizontal, 8)
                }
                .frame(height: 180)
                .padding(.bottom, 24)
                
                // Groen Archief
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        HStack(spacing: 0) {
                            Text("Groen")
                                .foregroundColor(Color(hex: 0x7FC241))
                            Text(" Archief")
                                .foregroundColor(.primary)
                        }
                        .font(.system(size: 28, weight: .semibold))
                        
                        Spacer()
                        
                        // Scanner button
                        Button(action: {
                        }) {
                            Image(systemName: "viewfinder")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.white)
                                .padding(.horizontal, 8)
                                .frame(height: 40)
                                .background(Color(hex: 0x89D152))
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                    }
                    // Subtext
                    Text("Hier zie je uw meest recente scan.")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.bottom, 16)

                    // Content
                    if let latest = archiveVM.archived.sorted(by: { $0.dateAdded > $1.dateAdded }).first {
                        NavigationLink(value: latest) {
                            ArchivedPlantCardView(plant: latest)
                        }
                        .buttonStyle(.plain)
                        .frame(maxWidth: .infinity)
                    } else {
                        VStack(spacing: 8) {
                            Image(systemName: "viewfinder")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.gray.opacity(0.5))
                                
                            Text("Maak je eerste scan.")
                                .foregroundColor(.gray)
                                .font(.subheadline)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 24)
                    }
                }
                .padding(.horizontal, 8)
                .padding(.bottom, 24)
                
                // News Section
                NewsSection()

                Spacer()
            }
            .padding(.horizontal, 8)
            .onAppear {
                archiveVM.fetchArchive()
                deviceVM.fetchDevices()
                if let location = locationManager.location {
                    viewModel.fetchWeather(for: location)
                }
            }
            .onReceive(locationManager.$location.compactMap { $0 }) { location in
                viewModel.fetchWeather(for: location)
            }
            .sheet(isPresented: $showingSettings) {
                NavigationStack {
                    SettingsView()
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct WeatherBox: View {
    let icon: String
    let value: String

    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: icon)
            Text(value)
                .fontWeight(.medium)
        }
        .frame(maxWidth: .infinity, minHeight: 60)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .stroke(colorScheme == .dark ? Color.white : Color.black.opacity(0.2), lineWidth: 1)
        )
    }
}

struct FilterButton: View {
    let title: String
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        Text(title)
            .font(.system(size: 16, weight: .regular))
            .foregroundColor(colorScheme == .dark ? .white : .primary)
            .frame(height: 40)
            .padding(.horizontal, 16)
            .background(Color.clear)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(colorScheme == .dark ? Color.white : Color.black.opacity(0.8), lineWidth: 1)
            )
    }
}
