import SwiftUI

struct AchievementView: View {
    var body: some View {
        VStack(spacing: 15) {
            Image("badge")
                .resizable()
                .frame(width: 64, height: 64)
            
            Text("Achievement Unlocked!")
                .multilineTextAlignment(.center)
                .font(.body.weight(.semibold))
                .foregroundColor(.white)
        }
        .padding(.vertical, 16)
        .frame(width: 270)
        .background(Color.theme.text.second)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }

}

#Preview {
    AchievementView()
}
