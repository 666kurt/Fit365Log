import SwiftUI

struct WelcomeScreen: View {
    
    @StateObject var healthViewModel = HealthViewModel()
    @StateObject var trainingViewModel = TrainingViewModel()
    
    @State private var showAlert: Bool = false
    @State private var navigateToHealth: Bool = false
    @State private var navigateToTraining: Bool = false
    
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
                .customVStackStyle()
                
                if showAlert {
                    AlertView(showAlert: $showAlert,
                              title: "Reset progress",
                              description: "This will result in complete data loss, are you sure?",
                              onReset: resetProgress)
                }
                
                NavigationLink(destination: HealthScreen()
                    .environmentObject(healthViewModel),
                               isActive: $navigateToHealth) {}
                
                NavigationLink(destination: TrainingScreen()
                    .environmentObject(trainingViewModel),
                               isActive: $navigateToTraining) {}
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
                                     onAnimationCompletion: {
                                         navigateToHealth = true
                                     })
            
            WelcomeAnimateButtonView(emodji: "🚴🏼",
                                     title: "My\nTraining",
                                     description: "Proofread and record your workouts",
                                     animationType: .bike,
                                     onAnimationCompletion: {
                                         navigateToTraining = true
                                     })
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
    
    private func resetProgress() {
        healthViewModel.deleteAllData()
        trainingViewModel.deleteAllTrainings()
    }
}


#Preview {
    WelcomeScreen()
}
