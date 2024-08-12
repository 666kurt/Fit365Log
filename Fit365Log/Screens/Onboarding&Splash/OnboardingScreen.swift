import SwiftUI

struct OnboardingScreen: View {
    
    @Binding var showOnboarding: Bool
    @State private var currentTab = 0
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            TabView(selection: $currentTab) {
                
                OnboardingStepView(image: "onboarding1", 
                                   title: "Convenient navigation\nsystem",
                                   description: "Everything important is collected on\none screen").tag(0)
                
                OnboardingStepView(image: "onboarding2", 
                                   title: "Create your tasks\nand accomplish them",
                                   description: "Your health is under control").tag(1)
                
                OnboardingStepView(image: "onboarding3", 
                                   title: "Track your workouts",
                                   description: "Record your workouts, set new\ngoals for yourself").tag(2)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .ignoresSafeArea()
            
            
            HStack(alignment: .center) {
                CustomTabIndicator(currentTab: $currentTab, numberOfTabs: 3)
                Spacer()
                Button(action: {
                    if currentTab < 2 {
                        currentTab += 1
                    } else {
                        showOnboarding = false
                        UserDefaults.standard.set(true, forKey: "hasSeenOnboarding")
                    }
                }, label: {
                    Text("Next")
                        .bold()
                        .padding(.vertical, 10)
                        .padding(.horizontal, 55)
                        .foregroundColor(Color.theme.text.main)
                        .background(Color.theme.other.primary)
                        .clipShape(RoundedRectangle(cornerRadius: 18))
                })
            }
            .padding(.bottom, 30)
            .padding(.horizontal, 15)
        }
    }
}


#Preview {
    OnboardingScreen(showOnboarding: .constant(true))
}
