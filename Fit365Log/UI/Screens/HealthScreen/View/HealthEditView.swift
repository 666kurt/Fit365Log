import SwiftUI

struct HealthEditView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var healthViewModel: HealthViewModel
    
    @State private var myHorseImagePicker = false
    @State private var additionalHorseImagePicker = false
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 15) {
                TextFieldView(placeholder: "Age", text: $healthViewModel.age)
                    .keyboardType(.numberPad)
                TextFieldView(placeholder: "Weight", text: $healthViewModel.weight)
                    .keyboardType(.numberPad)
                TextFieldView(placeholder: "Height", text: $healthViewModel.height)
                    .keyboardType(.numberPad)
                TextFieldView(placeholder: "Experience", text: $healthViewModel.experience)
                    .keyboardType(.numberPad)
                
                HStack(spacing: 10) {
                    Text("My horse")
                        .frame(maxWidth: .infinity)
                    Spacer()
                    Button {
                        myHorseImagePicker = true
                    } label: {
                        if let imageData = healthViewModel.myHorseImageData, let uiImage = UIImage(data: imageData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 154, height: 120)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        } else {
                            Image(systemName: "photo")
                                .frame(width: 154, height: 120)
                                .background(Color.theme.other.separator)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                    }
                }
                
                HStack(spacing: 10) {
                    Text("Additional horse")
                        .frame(maxWidth: .infinity)
                    Spacer()
                    Button {
                        additionalHorseImagePicker = true
                    } label: {
                        if let imageData = healthViewModel.additionalHorseImageData, let uiImage = UIImage(data: imageData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 154, height: 120)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        } else {
                            Image(systemName: "photo")
                                .frame(width: 154, height: 120)
                                .background(Color.theme.other.separator)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                    }
                }

                
                ButtonView(title: "Add", disabled: isDisabled, action: {
                    healthViewModel.saveUserHealth()
                    presentationMode.wrappedValue.dismiss()
                })
            }
            .sheet(isPresented: $myHorseImagePicker) {
                ImagePicker { image in
                    healthViewModel.handleImageSelection(image: image)
                }
            }
            .sheet(isPresented: $additionalHorseImagePicker) {
                ImagePicker { image in
                    healthViewModel.handleImageSelection2(image: image)
                }
            }
        }
    }
    
    private var isDisabled: Bool {
        return healthViewModel.age.isEmpty ||
        healthViewModel.weight.isEmpty ||
        healthViewModel.height.isEmpty ||
        healthViewModel.experience.isEmpty
    }
    
}

#Preview {
    HealthEditView()
        .environmentObject(HealthViewModel())
}
