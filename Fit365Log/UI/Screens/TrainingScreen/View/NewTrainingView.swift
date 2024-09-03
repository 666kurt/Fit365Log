import SwiftUI

struct NewTrainingView: View {
    
    @EnvironmentObject var trainingViewModel: TrainingViewModel
    @Environment(\.presentationMode) var presentationMode
    
    private let categories = ["Training", "Hobby Horsing"]
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            ZStack(alignment: .bottom) {
                VStack(spacing: 15) {
                    
                    Picker("Category", selection: $trainingViewModel.category) {
                        ForEach(categories, id: \.self) {
                            Text($0)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .foregroundColor(Color.theme.text.main)
                    .background(Color.theme.other.separator)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .pickerStyle(.menu)
                    
                    TextFieldView(placeholder: "Name",
                                  text: $trainingViewModel.name)
                    
                    tagTextField
                    
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
        trainingViewModel.desc.isEmpty ||
        trainingViewModel.category.isEmpty
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
                    .foregroundColor(Color.theme.other.primary)
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
        .background(Color.theme.other.separator)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    
}

#Preview {
    NewTrainingView()
        .environmentObject(TrainingViewModel())
        .customVStackStyle()
}
