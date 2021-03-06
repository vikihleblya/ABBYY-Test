import UIKit
import SwiftDate

class AddNewTaskViewController: UIViewController {
    private var statusForNewTask = "New"
    var task: Task?
    var isInEditingStyle: Bool = false
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var commentTextView: UITextView!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var doneButton: UIButton!
    @IBAction func doneButtonTapped(_ sender: Any) {
        if isInEditingStyle && isDataForSaveCorrect(){
            editCurrentData()
            navigationController?.popToRootViewController(animated: true)
            return
        }
        if isDataForSaveCorrect(){
            saveNewData()
            navigationController?.popToRootViewController(animated: true)
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if isInEditingStyle{
            fillFieldsToEdit()
        }
        navigationItem.title = "Add new task"
        changeDoneButton()
        changeCommentTextView()
    }
    
    func fillFieldsToEdit(){
        nameTextField.text = task?.name
        commentTextView.text = task?.comment
        datePicker.date = task?.date as! Date
    }
    
    func changeDoneButton(){
        doneButton.layer.cornerRadius = doneButton.frame.height / 2
    }
    
    func changeCommentTextView(){
        commentTextView.layer.borderWidth = 0.5
        commentTextView.layer.borderColor = UIColor.lightGray.cgColor
        commentTextView.layer.cornerRadius = 5
    }
}

extension AddNewTaskViewController{
    func isDataForSaveCorrect() -> Bool{
        if nameTextField.text!.isEmpty{
            showError(with: "Fill name field")
            return false
        }
        if datePicker.date.isInPast{
            showError(with: "Date cannot be in the past")
            return false
        }
        if commentTextView.text.isEmpty{
            showError(with: "Fill comment field")
            return false
        }
        return true
    }
    func showError(with message: String){
        let alertController = UIAlertController(title: "Failed to add new task", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func editCurrentData(){
        task?.date = datePicker.date as NSDate
        task?.comment = commentTextView.text
        task?.name = nameTextField.text
        CoreDataManager.instance.saveContext()
    }
    
    func saveNewData(){
        let task = Task(context: CoreDataManager.instance.persistentContainer.viewContext)
        task.id = UUID()
        task.comment = commentTextView.text
        task.date = datePicker.date as NSDate
        task.name = nameTextField.text
        task.status = statusForNewTask
        CoreDataManager.instance.saveContext()
    }
}

