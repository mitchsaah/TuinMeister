import SwiftUI

struct SurveyView1: View {

    private let accentGreen = Color(hex: 0x7FC241)
    var deviceName: String
    var onNext: (PlantType) -> Void
    @Binding var path: [ConnectionStep]
    
    enum PlantType: String {
        case indoor = "Indoor (kamerplanten)"
        case outdoor = "Outdoor (tuinplanten)"
    }
    
    @State private var selectedType: PlantType? = nil
    
    var body: some View {
            VStack (spacing: 0){
                HStack {
                    Button(action: {
                        path.removeLast()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .foregroundColor(.primary)
                    }
                    .padding(.leading, 16)
                    
                    Spacer()
                    
                    // Step 1 - Text
                    HStack(spacing: 0) {
                        Text("Stap ")
                            .font(.headline)
                            .foregroundColor(.primary)
                        Text("1")
                            .font(.headline)
                            .foregroundColor(accentGreen)
                        Text(" van 2")
                            .font(.headline)
                            .foregroundColor(.primary)
                    }
                    
                    Spacer()
                    
                    // Dummy spacer (for centering text)
                    Color.clear
                        .frame(width: 32, height: 32)
                        .padding(.trailing, 16)
                }
                .padding(.vertical, 12)
                .background(Color(UIColor.systemBackground))
                
                VStack {
                    (
                    Text("Gebruik je voornamelijk ")
                        .foregroundColor(.primary) +
                    Text("indoor")
                        .foregroundColor(accentGreen) +
                    Text(" of ")
                        .foregroundColor(.primary) +
                    Text("outdoor")
                        .foregroundColor(accentGreen) +
                    Text(" planten?")
                        .foregroundColor(.primary)
                    )
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 24)
                    .padding(.top, 24)
                    
                    Spacer().frame(height: 32)
                    
                    VStack(spacing: 16) {
                        ForEach([PlantType.indoor, PlantType.outdoor], id: \.self) { type in
                            Button(action: {
                                withAnimation {
                                    selectedType = type
                                }
                            }) {
                                HStack {
                                    Text(type.rawValue)
                                        .font(.body)
                                        .fontWeight(.regular)
                                        .foregroundColor(selectedType == type ? .white : .primary)
                                    Spacer()
                                }
                                .padding(.horizontal, 16)
                                .frame(height: 50)
                                .background(
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 25)
                                            .fill(selectedType == type ? accentGreen : Color.clear)
                                        RoundedRectangle(cornerRadius: 25)
                                            .stroke(accentGreen, lineWidth: 2)
                                    }
                                )
                            }
                            .buttonStyle(PlainButtonStyle())
                            .padding(.horizontal, 24)
                        }
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        if let type = selectedType {
                            print("Selected type: \(type.rawValue)")
                            onNext(type)
                        }
                    }) {
                        Text("Volgende")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(selectedType == nil ? Color.gray.opacity(0.5) : accentGreen)
                            .foregroundColor(.white)
                            .cornerRadius(25)
                            .padding(.horizontal, 24)
                    }
                    .disabled(selectedType == nil)
                    .padding(.bottom, 24)
                }
                .navigationBarBackButtonHidden(true)
                .background(Color(UIColor.systemBackground).ignoresSafeArea())
            }
    }
}
