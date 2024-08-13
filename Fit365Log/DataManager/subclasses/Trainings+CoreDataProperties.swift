import Foundation
import CoreData


extension Training {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Training> {
        return NSFetchRequest<Training>(entityName: "Training")
    }

    @NSManaged public var name: String
    @NSManaged public var repetitions: String
    @NSManaged public var approaches: String
    @NSManaged public var weight: String
    @NSManaged public var trainingTime: String
    @NSManaged public var restTime: String
    @NSManaged public var desc: String
    @NSManaged public var id: UUID?

}

extension Training : Identifiable {

}
