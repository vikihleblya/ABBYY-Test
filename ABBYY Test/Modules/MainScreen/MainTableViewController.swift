import UIKit

class MainTableViewController: UITableViewController {
    private let heightForCell: CGFloat = 73.0
    private var fetchedResultsController = CoreDataManager.instance.fetchedResultsController(entityName: "Task", keyForSort: "date", ascending: true)
    private var tasks: [Task] = []{
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    @IBAction func goToAddTaskVC(_ sender: Any) {
        guard let addNewTaskVC = storyboard?.instantiateViewController(withIdentifier: "AddNewTaskVC") else {return}
        navigationController?.pushViewController(addNewTaskVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        fetchData()
    }

    func fetchData(){
        do {
            try fetchedResultsController.performFetch()
            tasks = fetchedResultsController.fetchedObjects as? [Task] ?? tasks
        } catch {
            print(error)
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if let sections = fetchedResultsController.sections {
            return sections[section].numberOfObjects
        } else {
            return 0
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! MainTaskTableViewCell
        cell.dateLabel.text = tasks[indexPath.row].date?.description
        cell.taskNameLabel.text = tasks[indexPath.row].taskName
        cell.statusLabel.text = tasks[indexPath.row].status
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForCell
    }


}

extension MainTableViewController{
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, view, nil) in
            CoreDataManager.instance.persistentContainer.viewContext.delete(self.tasks[indexPath.row])
            CoreDataManager.instance.saveContext()
            self.fetchData()
            self.tableView.deleteRows(at: [indexPath], with: .automatic)            
        }
        let edit = UIContextualAction(style: .normal, title: "Edit") { (action, view, nil) in
            guard let addNewTaskVC = self.storyboard?.instantiateViewController(withIdentifier: "AddNewTaskVC") as? AddNewTaskViewController else {return}
            addNewTaskVC.task = self.tasks[indexPath.row]
            addNewTaskVC.isInEditingStyle = true
            self.navigationController?.pushViewController(addNewTaskVC, animated: true)
        }
        edit.backgroundColor = UIColor.orange
        let configuration = UISwipeActionsConfiguration(actions: [delete, edit])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let done = UIContextualAction(style: .normal, title: "Mark as done") { (action, view, nil) in
            
        }
        done.backgroundColor = UIColor(displayP3Red: 47.0/255, green: 201.0/255, blue: 97.0/255, alpha: 1)
        let inProcess = UIContextualAction(style: .normal, title: "Mark as in progress") { (action, view, nil) in
            
        }
        let configuration = UISwipeActionsConfiguration(actions: [done, inProcess])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
}
