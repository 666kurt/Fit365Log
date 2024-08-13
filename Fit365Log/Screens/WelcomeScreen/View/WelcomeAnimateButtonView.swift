import SwiftUI

struct WelcomeAnimateButtonView: View {
    
    let emodji: String
    let title: String
    let description: String
    let animationType: AnimationType
    let onAnimationCompletion: () -> Void
    
    // Props for animating
    @State private var scale: CGFloat = 1.0
    @State private var offset: CGFloat = 0
    @State private var isAnimating = false
    
    enum AnimationType {
        case heart
        case bike
    }
    
    var body: some View {
        Button {
            if !isAnimating {
                startAnimation()
            }
        } label: {
                VStack(spacing: 10) {
                    Text(emodji)
                        .font(.system(size: 70))
                        .scaleEffect(scale)
                        .offset(x: animationType == .bike ? offset : 0)
                    
                    Text(title)
                        .font(.title2).bold()
                        .foregroundColor(Color.theme.text.main)
                    Text(description)
                        .font(.footnote)
                        .foregroundColor(Color.theme.background.second)
                        .lineLimit(2)
                }
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
                .padding(10)
                .background(Color.theme.text.second)
                .clipShape(RoundedRectangle(cornerRadius: 25))
        }
    }
    
    private func startAnimation() {
        isAnimating = true
        
        if animationType == .heart {
            withAnimation(.easeInOut(duration: 0.3)) {
                scale = 0.8
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation(.easeInOut(duration: 0.3)) {
                    scale = 1.2
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        scale = 1.0
                    }
                    isAnimating = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                        onAnimationCompletion()
                    }
                }
            }
        } else if animationType == .bike {
            let maxOffset = UIScreen.main.bounds.width / 2
            withAnimation(.linear(duration: 0.5)) {
                offset = -maxOffset
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                offset = maxOffset
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation(.linear(duration: 0.5)) {
                        offset = 0
                    }
                    isAnimating = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                        onAnimationCompletion()
                    }
                }
            }
        }
    }
}


#Preview {
//    WelcomeAnimateButtonView(emodji: "❤️",
//                             title: "My\nHealth",
//                             description: "All the important health points are stored here.",
//                             animationType: .heart,
//                             onAnimationCompletion: {})
    WelcomeScreen()
}
