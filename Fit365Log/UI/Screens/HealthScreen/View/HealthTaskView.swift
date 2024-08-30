import SwiftUI

struct HealthTaskView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var healthViewModel: HealthViewModel
    
    var body: some View {
        VStack(spacing: 15) {
            TextFieldView(placeholder: "Tasks", text: $healthViewModel.taskLabel)
            ButtonView(title: "Add", disabled: isDisabled, action: {
                healthViewModel.addTask()
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
    
    private var isDisabled: Bool {
        return healthViewModel.taskLabel.isEmpty
    }
    
}
