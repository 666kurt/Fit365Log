import SwiftUI

struct TimePickerView: View {
    let title: String
    let showPicker: () -> Void
    
    @Binding var minutes: Int
    @Binding var seconds: Int

    var body: some View {
        HStack(spacing: 10) {
            Text(title)
                .font(.body.weight(.semibold))
                .foregroundColor(Color.theme.text.main)
            
            Button {
                showPicker()
            } label: {
                Text(String(format: "%02d:%02d", minutes, seconds))
                    .padding(.horizontal, 11)
                    .padding(.vertical, 6)
                    .foregroundColor(Color.theme.text.second)
                    .background(Color.theme.background.light)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
            }
        }
    }
}


#Preview {
    TimePickerView(title: "Rest time", showPicker: {}, minutes: .constant(12), seconds: .constant(55))
        .customVStackStyle()
}
