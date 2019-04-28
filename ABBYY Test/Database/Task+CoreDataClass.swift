import Foundation
import CoreData

@objc(Task)
public class Task: NSManagedObject {
    convenience init() {
        self.init(entity: CoreDataManager.instance.entityForName(entityName: "Task"), insertInto: CoreDataManager.instance.persistentContainer.viewContext)
    }
}
