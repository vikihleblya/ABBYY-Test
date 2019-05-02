import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    @IBOutlet var nameTaskLabel: UILabel!
    @IBOutlet var dateTaskLabel: UILabel!
    @IBOutlet var infoTaskButton: UIButton!
    
    @IBAction func goToInfoViewController(_ sender: Any) {
        let url = URL(string: "openInfo://")
        self.extensionContext?.open(url!, completionHandler: nil)
    }
    
    private var context = CoreDataManager.instance.persistentContainer.viewContext
    private var fetchedResultsController = CoreDataManager.instance.fetchedResultsController(entityName: "Task", keyForSort: "date", ascending: true)
    private var tasks: [Task] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchData()
        guard let task = getNearestTaskByDate() else {
            nameTaskLabel.text = "No task"
            dateTaskLabel.text?.removeAll()
            infoTaskButton.isHidden = true
            return
        }
        nameTaskLabel.text = task.name
        dateTaskLabel.text = task.date?.convertToLocalDate()
        infoTaskButton.isHidden = false
        view.snapshotView(afterScreenUpdates: true)
     }
    
    func fetchData(){
        do {
            try fetchedResultsController.performFetch()
            tasks = fetchedResultsController.fetchedObjects as? [Task] ?? tasks
        } catch {
            print(error)
        }
    }
    
    func getNearestTaskByDate() -> Task? {
        let nearestDateTask = tasks.filter({$0.status != "Done"}).max { (task1, task2) -> Bool in
            let date1 = task1.date! as Date
            let date2 = task2.date! as Date
            return date1 > date2
        }
        return nearestDateTask
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        completionHandler(NCUpdateResult.newData)
    }
}
