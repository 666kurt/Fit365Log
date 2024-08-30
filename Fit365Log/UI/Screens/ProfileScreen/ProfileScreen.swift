import SwiftUI

struct ProfileScreen: View {
    
    @EnvironmentObject var healthViewModel: HealthViewModel
    @EnvironmentObject var trainingViewModel: TrainingViewModel
    @State private var showAlert: Bool = false
    @State private var isLandscape: Bool = false
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            if isLandscape {
                ScrollView(showsIndicators: false) {
                    content
                        .orientationReader(isLandscape: $isLandscape)
                }
            } else {
                content
                    .orientationReader(isLandscape: $isLandscape)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .colorScheme(.light)
    }
}

extension ProfileScreen {
    
    private var content: some View {
        ZStack {
            VStack(spacing: 30) {
                
                buttonsView
                
                achievementsView
                
                
            }
            .navigationTitle("My profile")
            .customVStackStyle()
            
            if showAlert {
                alertView
            }
        }
    }
    
    private var buttonsView: some View {
        VStack(spacing: 20) {
            ProfileLinkButtonView(image: "bubble.fill",
                                  title: "Contact us",
                                  url: "https://www.termsfeed.com/live/21eb4e40-4d76-4864-89d9-2b930589e845")
            ProfileLinkButtonView(image: "list.bullet.rectangle.portrait",
                                  title: "Terms of use",
                                  url: "https://www.termsfeed.com/live/21eb4e40-4d76-4864-89d9-2b930589e845")
            ProfileLinkButtonView(image: "shield.fill",
                                  title: "Privacy",
                                  url: "https://www.termsfeed.com/live/c4aeddd3-fed2-4c48-b24a-f47c4e040f3f")
            ProfileResetButtonView(showAlert: $showAlert)
        }
        .padding(.top, 16)
    }
    
    private var alertView: some View {
        AlertView(showAlert: $showAlert,
                  title: "Reset progress",
                  description: "This will result in complete data loss, are you sure?",
                  onReset: {
            trainingViewModel.deleteAllTrainings()
            healthViewModel.deleteAllTasks()
            healthViewModel.deleteUserData()
        })
    }
    
    private var achievementsView: some View {
        VStack(spacing: 10) {
            Text("Achievements")
                .font(.title2.weight(.bold))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: columns) {
                    ForEach(1...30, id: \.self) { i in
                        ProfileAchievementsView(value: i)
                            .opacity(i <= trainingViewModel.consecutiveTrainingDays() ? 1.0 : 0.5)
                    }
                }
            }
        }
    }
}

#Preview {
    MainView()
}
