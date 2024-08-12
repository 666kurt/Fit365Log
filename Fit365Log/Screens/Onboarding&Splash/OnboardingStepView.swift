import SwiftUI

struct OnboardingStepView: View {
    
    let image: String
    let title: String
    let description: String
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            Image(image)
                .resizable()
                .scaledToFill()
                .background(Color(hex: "#F9FFED").ignoresSafeArea())
            
            
            VStack(alignment: .leading, spacing: 10) {
                Text(title)
                    .font(.title.weight(.bold))
                    .foregroundColor(.black)
                Text(description)
                    .foregroundColor(Color(hex: "#454545"))
                
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 30)
            .frame(maxWidth: .infinity,
                   maxHeight: UIScreen.main.bounds.height / 3,
                   alignment: .topLeading)
            .background(Color(hex: "#D4EDBC"))
        }
    }
}

#Preview {
    OnboardingStepView(image: "onboarding2",
                       title: "Convenient navigation\nsystem",
                       description: "Everything important is collected on\none screen")
}
