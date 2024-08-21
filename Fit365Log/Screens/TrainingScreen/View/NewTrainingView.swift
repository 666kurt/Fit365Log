import SwiftUI

struct NewTrainingView: View {
    
    @EnvironmentObject var trainingViewModel: TrainingViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            ZStack(alignment: .bottom) {
                VStack(spacing: 15) {
                    
                    TextFieldView(placeholder: "Name",
                                  text: $trainingViewModel.name)
                    
                    tagTextField
                    
                    TextFieldView(placeholder: "Core muscle",
                                  text: $trainingViewModel.coreMuscle)
                    
                    TextFieldView(placeholder: "Secondary muscles",
                                  text: $trainingViewModel.secondaryMuscles)
                    
                    TextFieldView(placeholder: "Description",
                                  text: $trainingViewModel.desc)
                    
                    ButtonView(title: "Save", disabled: isDisabled, action: {
                        saveTraining()
                    })
                }
            }
        }
    }
    
    private func saveTraining() {
        
        let red = Double(trainingViewModel.tagColor.components.r)
        let green = Double(trainingViewModel.tagColor.components.g)
        let blue = Double(trainingViewModel.tagColor.components.b)
        let alpha = Double(trainingViewModel.tagColor.components.a)
        
        
        trainingViewModel.addTraining(alpha: alpha, red: red, green: green, blue: blue)
        presentationMode.wrappedValue.dismiss()
    }
    
    private var isDisabled: Bool {
        return trainingViewModel.name.isEmpty ||
        trainingViewModel.tag.isEmpty ||
        trainingViewModel.coreMuscle.isEmpty ||
        trainingViewModel.secondaryMuscles.isEmpty ||
        trainingViewModel.desc.isEmpty
    }
}


extension NewTrainingView {
    
    private var tagTextField: some View {
        
        HStack(alignment: .center, spacing: 5) {
            HStack(spacing: 15) {
                Text("Tag")
                    .font(.body.weight(.semibold))
                    .foregroundColor(Color.theme.text.main)
                
                Text("#")
                    .foregroundColor(Color.theme.background.second)
            }
            
            ZStack(alignment: .leading) {
                if trainingViewModel.tag.isEmpty {
                    Text("Choose")
                        .font(.callout)
                        .foregroundColor(
                            trainingViewModel.tag.isEmpty ? Color.theme.text.notActive : Color.theme.text.main
                        )
                }
                HStack {
                    TextField("", text: $trainingViewModel.tag)
                        .autocorrectionDisabled()
                    ColorPicker("", selection: $trainingViewModel.tagColor)
                        .frame(width: 30)
                }
                
                
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .foregroundColor(Color.theme.text.main)
        .background(Color.theme.background.light)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    
}

#Preview {
    NewTrainingView()
        .environmentObject(TrainingViewModel())
        .customVStackStyle()
}
