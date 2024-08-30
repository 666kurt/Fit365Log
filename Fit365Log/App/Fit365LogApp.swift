import SwiftUI

@main
struct Fit365LogApp: App {
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            SplashScreen(persistenceController: persistenceController)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
