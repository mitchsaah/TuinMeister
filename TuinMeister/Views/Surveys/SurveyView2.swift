import SwiftUI

struct SurveyView2: View {
    @Environment(\.presentationMode) private var presentationMode
    
    private let accentGreen = Color(hex: 0x7FC241)
    
    @State private var selectedPlantName: String? = nil
    @State private var showConfirmation: Bool = false
    @StateObject private var viewModel = PlantSearchViewModel()

    var body: some View {
        VStack (spacing: 0){
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .foregroundColor(.primary)
                }
                .padding(.leading, 16)
                
                Spacer()
                
                // Step 2 - Text
                HStack(spacing: 0) {
                    Text("Stap ")
                        .font(.headline)
                        .foregroundColor(.primary)
                    Text("2")
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
            .padding(.vertical)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    // Question 1 - title
                    HStack(spacing: 0) {
                        Text("Welke ")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                        Text("plant")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(accentGreen)
                        Text(" is het?")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                    }
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                }
                
                // Searchbar
                HStack(spacing: 8) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .font(.system(size: 20))

                    VStack(alignment: .leading, spacing: 2) {
                        Text("Zoekopdracht")
                            .font(.subheadline.weight(.semibold))
                            .foregroundColor(.secondary)

                        if let selected = selectedPlantName, showConfirmation {
                            HStack(spacing: 6) {
                                Text(selected)
                                    .foregroundColor(.white)
                                    .font(.subheadline)
                                    .padding(.vertical, 6)
                                    .padding(.horizontal, 12)
                                    .background(accentGreen)
                                    .cornerRadius(20)

                                Button {
                                    selectedPlantName = nil
                                    viewModel.searchText = ""
                                    showConfirmation = false
                                } label: {
                                    Image(systemName: "xmark")
                                        .font(.system(size: 12, weight: .bold))
                                        .foregroundColor(.white)
                                        .padding(6)
                                        .background(accentGreen)
                                        .clipShape(Circle())
                                }
                            }
                        } else {
                            TextField("Zoek een plantensoort…", text: $viewModel.searchText, onCommit: {
                                if !viewModel.searchText.trimmingCharacters(in: .whitespaces).isEmpty {
                                    selectedPlantName = viewModel.searchText
                                    showConfirmation = true
                                }
                            })
                            .font(.subheadline)
                            .foregroundColor(.primary)
                            .onChange(of: viewModel.searchText) {
                                viewModel.filterPlants(with: viewModel.searchText)
                                selectedPlantName = nil
                                showConfirmation = false
                            }
                        }
                    }

                    Spacer()
                }
                .padding(10)
                .background(Color.clear)
                .cornerRadius(32)
                .overlay(
                    RoundedRectangle(cornerRadius: 32)
                        .stroke(accentGreen, lineWidth: 1.5)
                )
                .padding(.horizontal)
                
                // Suggestion list
                if !viewModel.filteredPlants.isEmpty && !showConfirmation {
                    VStack(alignment: .leading, spacing: 12) {
                        ForEach(viewModel.filteredPlants) { plant in
                            Button {
                                selectedPlantName = plant.name
                                viewModel.searchText = plant.name
                                showConfirmation = true
                            } label: {
                                HStack(spacing: 12) {
                                    if let urlString = plant.imageUrl,
                                       let url = URL(string: urlString) {
                                        AsyncImage(url: url) { image in
                                            image.resizable()
                                        } placeholder: {
                                            ProgressView()
                                        }
                                        .frame(width: 40, height: 40)
                                        .cornerRadius(8)
                                    } else {
                                        Image(systemName: "leaf")
                                            .resizable()
                                            .frame(width: 25, height: 25)
                                            .foregroundColor(.green)
                                    }
                                    
                                    Text(plant.name)
                                        .foregroundColor(.primary)
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                    .padding(.top, 4)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                // Question 2 - title
                VStack(alignment: .leading, spacing: 6) {
                    Text("Naam plant")
                        .font(.subheadline.weight(.semibold))
                        .foregroundColor(.primary)

                    TextField("Persoonlijke naam (Eg. Marcus)", text: $customPlantName)
                        .font(.subheadline)
                        .padding()
                        .background(Color.clear)
                        .cornerRadius(32)
                        .overlay(
                            RoundedRectangle(cornerRadius: 32)
                                .stroke(accentGreen, lineWidth: 1.5)
                        )
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
        .navigationBarBackButtonHidden(true)
    }
}
