import SwiftUI

struct HealthEditView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var name: String
    @Binding var age: String
    @Binding var weight: String
    @Binding var height: String
    @Binding var waist: String
    @Binding var heartRate: String
    @Binding var caloriesPerDay: String
    @Binding var diseases: String
    
    var onSave: () -> Void
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 15) {
                TextFieldView(placeholder: "Name", text: $name)
                TextFieldView(placeholder: "Age", text: $age)
                    .keyboardType(.numberPad)
                TextFieldView(placeholder: "Weight", text: $weight)
                    .keyboardType(.numberPad)
                TextFieldView(placeholder: "Height", text: $height)
                    .keyboardType(.numberPad)
                TextFieldView(placeholder: "Waist", text: $waist)
                    .keyboardType(.numberPad)
                TextFieldView(placeholder: "Heart rate", text: $heartRate)
                    .keyboardType(.numberPad)
                TextFieldView(placeholder: "Calories per day", text: $caloriesPerDay)
                    .keyboardType(.numberPad)
                TextFieldView(placeholder: "Diseases", text: $diseases)
                ButtonView(title: "Add", disabled: isDisabled, action: {
                    onSave()
                    presentationMode.wrappedValue.dismiss()
                })
            }
        }
    }
    
    private var isDisabled: Bool {
        return name.isEmpty ||
        age.isEmpty ||
        weight.isEmpty ||
        height.isEmpty ||
        waist.isEmpty ||
        heartRate.isEmpty ||
        caloriesPerDay.isEmpty ||
        diseases.isEmpty
    }
    
}
