import CoreData
import SwiftUI

struct PersistenceController {
    
    static let shared = PersistenceController()

    let container: NSPersistentContainer
    
    static var preview: PersistenceController = {
        let result = PersistenceController()
        let viewContext = result.container.viewContext
        return result
    }()

    private init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Fit365Log")
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }

    var viewContext: NSManagedObjectContext {
        container.viewContext
    }
}
