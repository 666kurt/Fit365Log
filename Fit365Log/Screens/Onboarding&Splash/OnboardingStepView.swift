import SwiftUI

struct OnboardingStepView: View {
    
    let image: String
    let title: String
    let description: String
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .scaleEffect(1.1)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text(title)
                        .font(.title.weight(.bold))
                        .foregroundColor(.black)
                    Text(description)
                        .foregroundColor(Color(hex: "#454545"))
                }
                .padding(.horizontal, 15)
                .padding(.vertical, 30)
                .frame(maxWidth: .infinity, maxHeight: geometry.size.height / 3, alignment: .topLeading)
                .background(Color(hex: "#D4EDBC").ignoresSafeArea())
            }
        }
    }
}
#Preview {
    OnboardingStepView(image: "onboarding2",
                       title: "Convenient navigation\nsystem",
                       description: "Everything important is collected on\none screen")
}
