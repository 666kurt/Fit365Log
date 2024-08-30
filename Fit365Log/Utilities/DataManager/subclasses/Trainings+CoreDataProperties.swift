import Foundation
import CoreData


extension Training {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Training> {
        return NSFetchRequest<Training>(entityName: "Training")
    }

    @NSManaged public var name: String
    @NSManaged public var coreMuscle: String
    @NSManaged public var secondaryMuscles: String
    @NSManaged public var desc: String
    @NSManaged public var tag: String
    @NSManaged public var alpha: Double
    @NSManaged public var red: Double
    @NSManaged public var green: Double
    @NSManaged public var blue: Double
    @NSManaged public var id: UUID?
    @NSManaged public var date: Date?


}

extension Training : Identifiable {

}
