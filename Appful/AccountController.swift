import UIKit

class AccountController: UIViewController {
    
    @IBOutlet weak var welcomeMsgLabel: UILabel!
    var user: User?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let currentUser = user {
             welcomeMsgLabel.text = "Hello \(currentUser.firstName)!"
        }
    }
}
