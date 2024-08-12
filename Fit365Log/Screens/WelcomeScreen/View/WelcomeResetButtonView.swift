import SwiftUI

struct WelcomeResetButtonView: View {
    
    @Binding var showAlert: Bool
    
    var body: some View {
        Button {
            $showAlert.wrappedValue.toggle()
        } label: {
            HStack(spacing: 5) {
                Image(systemName: "arrow.clockwise")
                    .font(.title3.weight(.bold))
                Text("Reset progress")
                    .font(.body.weight(.bold))
            }
            .frame(maxWidth: .infinity)
            .padding(12)
            .foregroundColor(Color.theme.text.main)
            .background(Color.theme.other.primary)
            .clipShape(Capsule())
        }
    }
}

#Preview {
    WelcomeResetButtonView(showAlert: .constant(false))
        .padding()
}
