import UIKit
import SwiftDate

class AddNewTaskViewController: UIViewController {

    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var commentTextView: UITextView!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var doneButton: UIButton!
    @IBAction func doneButtonTapped(_ sender: Any) {
        if checkDataForSave(){
            saveNewData()
            navigationController?.popToRootViewController(animated: true)
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false
        changeDoneButton()
        changeCommentTextView()
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
    func checkDataForSave() -> Bool{
        if commentTextView.text.isEmpty || nameTextField.text == ""{
            showError(with: "Fill all empty fields")
            return false
        }
        if datePicker.date.isInPast{
            showError(with: "Date cannot be in the past")
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
    
    func saveNewData(){
        let task = Task(context: CoreDataManager.instance.persistentContainer.viewContext)
        task.id = UUID()
        task.comment = commentTextView.text
        task.date = datePicker.date as NSDate
        task.taskName = nameTextField.text
        CoreDataManager.instance.saveContext()
    }
}
