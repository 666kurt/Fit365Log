import SwiftUI

@main
struct Fit365LogApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            WelcomeScreen()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
