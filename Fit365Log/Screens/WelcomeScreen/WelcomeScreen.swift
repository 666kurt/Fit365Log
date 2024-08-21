import SwiftUI

struct WelcomeScreen: View {
    
    @StateObject var healthViewModel = HealthViewModel()
    @StateObject var trainingViewModel = TrainingViewModel()
    
    @State private var showAlert: Bool = false
    @State private var navigateToHealth: Bool = false
    @State private var navigateToTraining: Bool = false
    @State private var isLandscape: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                if isLandscape {
                    ScrollView {
                        content
                    }
                    .padding(.vertical, 20)
                    .customVStackStyle()
                } else {
                    content
                }
                
                if showAlert {
                    AlertView(showAlert: $showAlert,
                              title: "Reset progress",
                              description: "This will result in complete data loss, are you sure?",
                              onReset: resetProgress)
                }
                
                NavigationLink(destination: HealthScreen()
                    .environmentObject(healthViewModel),
                               isActive: $navigateToHealth) {
                    EmptyView()
                }.hidden()
                
                NavigationLink(destination: TrainingScreen()
                    .environmentObject(trainingViewModel),
                               isActive: $navigateToTraining) {
                    EmptyView()
                }.hidden()
                
            }
            .navigationTitle("")
            .navigationBarHidden(true)
            .orientationReader(isLandscape: $isLandscape)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

extension WelcomeScreen {
    
    private var content: some View {
        VStack {
            titleView
            animateButtonView
            tabButtonView
        }
        .padding(.vertical, 20)
        .customVStackStyle()
    }
    
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
        .frame(maxHeight: .infinity, alignment: .top)
    }
    
    private var tabButtonView: some View {
        VStack(spacing: 20) {
            WelcomeLinkButtonView(image: "bubble.fill",
                                  title: "Contact us",
                                  url: "https://www.termsfeed.com/live/21eb4e40-4d76-4864-89d9-2b930589e845")
            WelcomeLinkButtonView(image: "list.bullet.rectangle.portrait",
                                  title: "Terms of use",
                                  url: "https://www.termsfeed.com/live/21eb4e40-4d76-4864-89d9-2b930589e845")
            WelcomeLinkButtonView(image: "shield.fill", 
                                  title: "Privacy",
                                  url: "https://www.termsfeed.com/live/c4aeddd3-fed2-4c48-b24a-f47c4e040f3f")
            WelcomeResetButtonView(showAlert: $showAlert)
        }
        .padding(.top, 16)
    }
    
    private func resetProgress() {
        healthViewModel.deleteUserData()
        healthViewModel.deleteAllTasks()
        trainingViewModel.deleteAllTrainings()
    }
}

#Preview {
    WelcomeScreen()
}
