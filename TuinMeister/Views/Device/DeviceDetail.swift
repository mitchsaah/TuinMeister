import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseDatabase

struct DeviceDetailView: View {
    @Environment(\.dismiss) private var dismiss
    let device: Device
    private let accentGreen = Color(hex: 0x7FC241)
    
    @State private var typeText: String = ""
    @State private var plantDate: Date = Date()
    
    @State private var soilMoisture: Int = 0
    @State private var humidity: Int = 0
    @State private var uvLevel: Double = 0.0
    @State private var careLevel: String = ""
    @State private var waterGiven = false
    
    private var typeFirstWord: String {
        typeText.split(separator: " ").first.map(String.init) ?? typeText
    }
    
    private var ageText: String {
        let years = Calendar.current
            .dateComponents([.year], from: plantDate, to: Date())
            .year ?? 0
        return "\(max(0, years)) jaar"
    }
    
    private var waterAdvice: String? {
        guard !waterGiven, !careLevel.isEmpty else { return nil }

        let threshold: Int = {
            switch careLevel.lowercased() {
            case "high": return 50
            case "low": return 20
            default: return 35
            }
        }()

        if soilMoisture < threshold {
            let amount: Int = {
                switch careLevel.lowercased() {
                case "high": return 250
                case "low": return 100
                default: return 200
                }
            }()
            return "Heeft \(amount)ml water nodig!"
        }
        return nil
    }

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .foregroundColor(.primary)
                }
                .frame(width: 44, height: 44)

                Spacer()

                Text(device.customName)
                    .font(.headline)
                    .foregroundColor(.primary)

                Spacer()

                Color.clear.frame(width: 44, height: 44)
            }
            .padding(.horizontal)
            .padding(.top, 8)

            Spacer()
            
            ScrollView {
                VStack(spacing: 24) {
                    if let url = URL(string: device.imageUrl), !device.imageUrl.isEmpty {
                        AsyncImage(url: url) { img in
                            img
                                .resizable()
                                .scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(maxWidth: .infinity, maxHeight: 200)
                        .cornerRadius(12)
                        .padding(.horizontal)
                        .padding(.top, 16)
                    } else {
                        Image(systemName: "leaf")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 90, height: 90)
                            .foregroundColor(accentGreen)
                            .padding(.top, 16)
                    }
                    
                    HStack {
                        // Device #
                        VStack(alignment: .leading, spacing: 4) {
                            Text("TM")
                                .font(.caption)
                                .foregroundColor(.secondary)

                            Text(device.deviceName)
                                .font(.subheadline).fontWeight(.semibold)
                                .foregroundColor(accentGreen)
                        }

                        Spacer()

                        // Type
                        VStack(spacing: 4) {
                            Text("Type")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Text(typeFirstWord)
                                .font(.subheadline).fontWeight(.semibold)
                                .foregroundColor(.primary)
                        }

                        Spacer()
                        
                        // Age
                        VStack(spacing: 4) {
                            Text("Leeftijd")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Text(ageText)
                                .font(.subheadline).fontWeight(.semibold)
                                .foregroundColor(.primary)
                        }
                    }
                    .padding(.horizontal)
                    
                    // Needs of plant
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Benodigdheden")
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        if careLevel.isEmpty {
                            Text("Info voor deze plant is nog niet bekend. Wordt binnen 24h geüpdatet.")
                                .font(.system(size: 12))
                                .foregroundColor(.secondary)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        } else if let advice = waterAdvice {
                            HStack(spacing: 12) {
                                HStack(spacing: 8) {
                                    Image(systemName: "drop.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 20, height: 20)
                                        .foregroundColor(.orange)
                                    
                                    Text(advice)
                                        .font(.system(size: 12))
                                        .foregroundColor(.primary)
                                }
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.primary, lineWidth: 1)
                                )
                                
                                Button(action: {
                                    waterGiven = true
                                }) {
                                    Text("Markeer als gedaan")
                                        .font(.system(size: 12))
                                        .foregroundColor(.primary)
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 8)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(Color.primary, lineWidth: 1)
                                        )
                                }
                            }
                        } else {
                            Text("Jouw plant heeft momenteel niets nodig.")
                                .font(.system(size: 12))
                                .foregroundColor(.secondary)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 32)
                    .padding(.bottom, 32)
                    
                    // Stats section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Statistieken van jouw plant")
                            .font(.headline)
                            .foregroundColor(.primary)

                        HStack(spacing: 12) {
                            if careLevel.isEmpty {
                                statBox(title: "Bodemvocht", value: "\(soilMoisture)%", color: .gray)
                                statBox(title: "Luchtvocht.", value: "\(humidity)%", color: .gray)
                                statBox(title: "UV's", value: "\(uvLevel)", color: .gray)
                            } else {
                                let soilThresholds = getSoilThresholds(for: careLevel)
                                let uvThresholds = getUVThresholds()
                                statBox(title: "Bodemvocht", value: "\(soilMoisture)%", color: getColor(for: soilMoisture, thresholds: soilThresholds))
                                statBox(title: "Luchtvocht.", value: "\(humidity)%", color: getColor(for: humidity, thresholds: (25, 50)))
                                statBox(title: "UV's", value: "\(uvLevel)", color: getColor(for: uvLevel, thresholds: uvThresholds))
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .onAppear {
            loadDeviceDetail()
            loadRealtimeData()
        }
    }
    
    func getColor<T: Comparable>(for value: T, thresholds: (low: T, high: T)) -> Color {
        if value < thresholds.low { return .red }
        else if value < thresholds.high { return .orange }
        else { return .green }
    }

    
    private func getSoilThresholds(for careLevel: String) -> (low: Int, high: Int) {
        switch careLevel.lowercased() {
        case "low": return (20, 40)
        case "high": return (50, 70)
        default: return (35, 60)
        }
    }
    
    private func getUVThresholds() -> (low: Double, high: Double) {
        let isIndoor = typeText.lowercased().contains("indoor")
        return isIndoor ? (1.5, 3.0) : (3.0, 6.0)
    }

    @ViewBuilder
       func statBox(title: String, value: String, color: Color) -> some View {
           VStack(spacing: 4) {
               Text(title)
                   .font(.caption)
                   .foregroundColor(.secondary)
               Text(value)
                   .font(.title2)
                   .fontWeight(.bold)
                   .foregroundColor(.primary)
           }
           .frame(maxWidth: .infinity, minHeight: 80)
           .background(
               RoundedRectangle(cornerRadius: 12)
                   .stroke(Color.primary, lineWidth: 1)
           )
       }
    
    private func loadRealtimeData() {
        let ref = Database.database(
            url: "https://tuinmeister-9352f-default-rtdb.europe-west1.firebasedatabase.app"
        ).reference()

        ref.child("devices").child(device.deviceName).observe(.value) { snapshot in
            if let dict = snapshot.value as? [String: Any] {
                self.soilMoisture = dict["soilMoisture"] as? Int ?? 0
                self.humidity = dict["humidity"] as? Int ?? 0
                self.uvLevel = dict["uvLevel"] as? Double ?? 0.0
            }
        }
    }
    
    private func loadDeviceDetail() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
            Firestore.firestore()
                .collection("users")
                .document(uid)
                .collection("devices")
                .document(device.deviceName)
                .getDocument { snap, err in
                    guard let data = snap?.data(), err == nil else { return }
                    self.typeText = data["type"] as? String ?? ""
                    if let ts = data["plantDate"] as? Timestamp {
                        self.plantDate = ts.dateValue()
                    }
                    
                    let plantName = data["plantName"] as? String ?? ""
                    Firestore.firestore().collection("plants").document(plantName).getDocument { doc, _ in
                        if let plantData = doc?.data() {
                            self.careLevel = plantData["careLevel"] as? String ?? ""
                        } else {
                            self.careLevel = ""
                        }
                    }
                }
    }
}
