import UIKit

class InfoTaskViewController: UIViewController {
    var task: Task?
    @IBOutlet var commentTextView: UITextView!
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        writeDataInFields()
        navigationItem.title = "Info"
    }
    
    func writeDataInFields(){
        nameLabel.text = task?.name
        statusLabel.text = task?.status
        commentTextView.text = task?.comment
        dateLabel.text = task?.date?.description
    }
}
