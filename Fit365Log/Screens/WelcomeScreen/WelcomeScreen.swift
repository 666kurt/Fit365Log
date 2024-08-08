import SwiftUI

struct WelcomeScreen: View {
    
    @State private var showAlert: Bool = false
    @State private var healthTapped: Bool = false
    @State private var trainingTapped: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    titleView
                    
                    animateButtonView
                    
                    Spacer()
                    
                    tabButtonView
                }
                .padding(.vertical, 20)
                .padding(.horizontal, 15)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .background(Color.theme.background.main.ignoresSafeArea())
                
                if showAlert {
                    AlertView(showAlert: $showAlert,
                              title: "Reset progress",
                              description: "This will result in complete data loss, are you sure?",
                              onReset: {})
                }
            }
        }
    }
}

extension WelcomeScreen {
    
    private var titleView: some View {
        Text("Welcome to\nFit365Log")
            .foregroundColor(Color.theme.text.main)
            .font(.largeTitle).bold()
            .multilineTextAlignment(.center)
    }
    
    private var animateButtonView: some View {
        HStack(spacing: 10) {
            WelcomeAnimateButtonView(emodji: "❤️",
                                     title: "My\nHealth",
                                     description: "All the important health points are stored here.",
                                     animationType: .heart,
                                     tapped: $healthTapped)
            
            WelcomeAnimateButtonView(emodji: "🚴🏼",
                                     title: "My\nTraining",
                                     description: "Proofread and record your workouts",
                                     animationType: .bike,
                                     tapped: $trainingTapped)
        }
    }
    
    private var tabButtonView: some View {
        VStack(spacing: 20) {
            WelcomeLinkButtonView(image: "bubble.fill", title: "Contact us")
            WelcomeLinkButtonView(image: "list.bullet.rectangle.portrait", title: "Terms of use")
            WelcomeLinkButtonView(image: "shield.fill", title: "Privacy")
            WelcomeResetButtonView(showAlert: $showAlert)
        }
    }
    
}

#Preview {
    WelcomeScreen()
}
