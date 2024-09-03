import Foundation
import CoreData


extension HealthData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HealthData> {
        return NSFetchRequest<HealthData>(entityName: "HealthData")
    }

    @NSManaged public var age: String
    @NSManaged public var weight: String
    @NSManaged public var height: String
    @NSManaged public var experience: String
    @NSManaged public var horseImage: Data?
    @NSManaged public var additionalImage: Data?

}

extension HealthData : Identifiable {

}
