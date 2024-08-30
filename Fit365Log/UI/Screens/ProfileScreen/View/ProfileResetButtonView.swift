import SwiftUI

struct ProfileResetButtonView: View {
    
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
            .foregroundColor(Color(hex: "#FAFAFA"))
            .background(Color.theme.other.primary)
            .clipShape(Capsule())
        }
    }
}

#Preview {
    ProfileResetButtonView(showAlert: .constant(false))
        .padding()
}
