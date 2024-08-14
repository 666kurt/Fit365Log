import SwiftUI

struct NewTrainingView: View {
    
    @EnvironmentObject var trainingViewModel: TrainingViewModel
    @Environment(\.presentationMode) var presentationMode
    
    @State private var showTimePicker: Bool = false
    @State private var timePickerType: TimePickerType? = .training
    
    enum TimePickerType {
        case training
        case rest
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            ZStack(alignment: .bottom) {
                VStack(spacing: 15) {
                    
                    TextFieldView(placeholder: "Name",
                                  text: $trainingViewModel.name)
                    
                    TextFieldView(placeholder: "Repetitions",
                                  text: $trainingViewModel.repetitions)
                    .keyboardType(.numberPad)
                    
                    TextFieldView(placeholder: "Approaches",
                                  text: $trainingViewModel.approaches)
                    .keyboardType(.numberPad)
                    
                    TextFieldView(placeholder: "Weight",
                                  text: $trainingViewModel.weight)
                    .keyboardType(.numberPad)
                    
                    HStack {
                        TimePickerView(title: "Training time",
                                       showPicker: {
                            timePickerType = .training
                            showTimePicker.toggle()
                        },
                                       minutes: $trainingViewModel.trainingMinutes,
                                       seconds: $trainingViewModel.trainingSeconds)
                        
                        Spacer()
                        
                        TimePickerView(title: "Rest time",
                                       showPicker: {
                            timePickerType = .rest
                            showTimePicker.toggle()
                        },
                                       minutes: $trainingViewModel.restMinutes,
                                       seconds: $trainingViewModel.restSeconds)
                    }
                    .padding(.horizontal, 4)
                    
                    TextFieldView(placeholder: "Description",
                                  text: $trainingViewModel.desc)
                    
                    ButtonView(title: "Save", disabled: isDisabled, action: {
                        trainingViewModel.addTraining()
                        presentationMode.wrappedValue.dismiss()
                    })
                }
            }
        }
        .sheet(isPresented: $showTimePicker) {
            if let timePickerType = timePickerType {
                TimePickerSheet(
                    minutes: timePickerType == .training ? $trainingViewModel.trainingMinutes : $trainingViewModel.restMinutes,
                    seconds: timePickerType == .training ? $trainingViewModel.trainingSeconds : $trainingViewModel.restSeconds,
                    onDismiss: { showTimePicker = false }
                )
            }
        }
    }
    
    private var isDisabled: Bool {
        return trainingViewModel.name.isEmpty ||
        trainingViewModel.repetitions.isEmpty ||
        trainingViewModel.approaches.isEmpty ||
        trainingViewModel.weight.isEmpty ||
        trainingViewModel.desc.isEmpty
    }
}


#Preview {
    NewTrainingView()
        .environmentObject(TrainingViewModel())
        .customVStackStyle()
}
