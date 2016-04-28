import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var login: UIButton!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    private(set) var user: User? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func perform(sender: AnyObject) {
        let email = self.email.text ?? ""
        let password = self.password.text ?? ""
        
        authentication(email, password)
            .onStart{
                ActivityIndicator.show()
            }
            .onSuccess{ user in
                self.user = user
            }
            .onError{ error in
                print(error)
            }
            .onComplete{
                ActivityIndicator.hide()
                mainQueue{ self.showAccountController() }
            }
    }
    
    private func showAccountController() {
        if user == nil {
            showAuthenticationError()
        } else {
            performSegueWithIdentifier("showAccount", sender: self)
        }
    }
    
    private func showAuthenticationError() {
        let alert = alertController("Authentication Failed", "Wrong email/password")
        presentViewController(alert, animated: true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destination = segue.destinationViewController as? AccountController {
            destination.user = self.user
        }
    }
}






