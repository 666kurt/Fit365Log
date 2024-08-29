import SwiftUI

struct ProfileAchievementsView: View {
    
    let value: Int
    
    var body: some View {
        VStack(spacing: 15) {
            Image("badge")
                .resizable()
                .frame(width: 64, height: 64)
            
            Text("Training for\n\(value) day")
                .multilineTextAlignment(.center)
                .font(.body.weight(.semibold))
                .foregroundColor(.white)
        }
        .padding(.vertical, 16)
        .frame(maxWidth: .infinity)
        .background(Color.theme.text.second)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    ProfileAchievementsView(value: 23)
        .padding()
}
