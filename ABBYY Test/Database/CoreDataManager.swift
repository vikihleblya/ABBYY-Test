import Foundation
import CoreData

class CoreDataManager {
    static let instance = CoreDataManager()
    
    init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = PersistentContainer(name: "ABBYY_Test")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func entityForName(entityName: String) -> NSEntityDescription {
        return NSEntityDescription.entity(forEntityName: entityName, in: self.persistentContainer.viewContext)!
    }
    
    func fetchedResultsController(entityName: String, keyForSort: String, ascending: Bool) -> NSFetchedResultsController<NSFetchRequestResult> {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let sortDescriptor = NSSortDescriptor(key: keyForSort, ascending: ascending)
        fetchRequest.sortDescriptors = [sortDescriptor]
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataManager.instance.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedResultsController
    }
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func performFetchTasks(entityName: String, keyForSort: String, ascending: Bool) -> [Task?] {
        var tasks: [Task?] = []
        let resultsController = fetchedResultsController(entityName: entityName, keyForSort: keyForSort, ascending: ascending)
        do {
            try resultsController.performFetch()
            tasks = resultsController.fetchedObjects as? [Task] ?? []
        } catch {
            print(error)
        }
        return tasks
    }
    
}

// MARK: - Container to work with App Groups

class PersistentContainer: NSPersistentContainer{
    override class func defaultDirectoryURL() -> URL{
        return FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.AbbyyTest")!
    }
}
