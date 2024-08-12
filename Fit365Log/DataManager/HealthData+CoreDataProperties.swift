import Foundation
import CoreData


extension HealthData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HealthData> {
        return NSFetchRequest<HealthData>(entityName: "HealthData")
    }

    @NSManaged public var name: String
    @NSManaged public var age: String
    @NSManaged public var weight: String
    @NSManaged public var height: String
    @NSManaged public var waist: String
    @NSManaged public var heartRate: String
    @NSManaged public var calories: String
    @NSManaged public var diseases: String

}

extension HealthData : Identifiable {

}
