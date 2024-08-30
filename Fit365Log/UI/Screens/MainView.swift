import SwiftUI

struct MainView: View {
    
    @StateObject var router = Router.shared
    @StateObject var healthViewModel = HealthViewModel()
    @StateObject var trainingViewModel = TrainingViewModel()
    
    var body: some View {
        
        TabView(selection: $router.selectedScreen) {
            
            HomeScreen()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }.tag(Screens.home)
            
            HealthScreen()
                .environmentObject(healthViewModel)
                .tabItem {
                    Label("My Health", systemImage: "heart.fill")
                }.tag(Screens.health)
            
            TrainingScreen()
                .environmentObject(trainingViewModel)
                .tabItem {
                    Label("My training", systemImage: "figure.strengthtraining.traditional")
                }.tag(Screens.training)
            
            ProfileScreen()
                .environmentObject(trainingViewModel)
                .environmentObject(healthViewModel)
                .tabItem {
                    Label("My profile", systemImage: "person.fill")
                }.tag(Screens.profile)
            
        }.colorScheme(.light)
    }
}

#Preview {
    MainView()
}
