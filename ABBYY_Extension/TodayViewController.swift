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
    private var tasks: [Task] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tasks = CoreDataManager.instance.performFetchTasks(entityName: "Task", keyForSort: "date", ascending: true) as! [Task]
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
    

    func getNearestTaskByDate() -> Task? {
        let nearestDateTask = tasks.filter({$0.status != "Done"}).first
        return nearestDateTask
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        completionHandler(NCUpdateResult.newData)
    }
}
