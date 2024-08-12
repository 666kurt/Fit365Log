import SwiftUI

struct ButtonView: View {
    
    let title: String
    let disabled: Bool
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(title)
                .font(.body.weight(.bold))
                .padding(12)
                .frame(maxWidth: .infinity)
                .background(Color.theme.other.primary)
                .clipShape(Capsule())
                .foregroundColor(Color.theme.text.main)
                .opacity(disabled ? 0.5 : 1)
        }.disabled(disabled)
    }
    
    
    
}

#Preview {
    ButtonView(title: "Save", disabled: true, action: {})
        .padding()
}
