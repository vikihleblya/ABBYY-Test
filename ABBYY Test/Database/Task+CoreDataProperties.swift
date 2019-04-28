import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var comment: String?
    @NSManaged public var date: NSDate?
    @NSManaged public var id: UUID?
    @NSManaged public var taskName: String?
    @NSManaged public var status: String?

}
