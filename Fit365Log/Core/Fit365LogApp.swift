import SwiftUI

@main
struct Fit365LogApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    let persistenceController = PersistenceController.shared
    
    @State private var showOnboarding = UserDefaults.standard.bool(forKey: "hasSeenOnboarding") == false

    var body: some Scene {
        WindowGroup {
            SplashScreen(showOnboarding: $showOnboarding, persistenceController: persistenceController)
                           .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
