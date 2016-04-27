import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var login: UIButton!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!

    var isAuthenticated = false {
        didSet {
            dispatch_sync(dispatch_get_main_queue()) { 
                self.performSegueWithIdentifier("showAccount", sender: self)
            }
        }
    }
    
    var user: User? {
        didSet {
            ActivityIndicator.hide()
            if user != nil { isAuthenticated = true }
            else { isAuthenticated = false }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destination = segue.destinationViewController as? AccountController {
            destination.user = user
        }
    }

    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        return isAuthenticated
    }
    
    private func authentication(email: String, _ password: String) {
        fetchToken(email, password){ data, _, error in
            if let err = error { print(err) }
            if let jsonData = data{
                if let authenticationToken = token(jsonData) {
                    self.fetchUser(authenticationToken)
                }
            }
        }
    }
    
    private func fetchUser(token: String) {
        fetchAccount(token) { data, _, error in
            if let err = error { print(err) }
            if let jsonData = data {
                if let model = userModel(jsonData) {
                    self.user = model
                }
            }
        }
    }
    
    @IBAction func perform(sender: AnyObject) {
        ActivityIndicator.show()
        let email = self.email.text ?? ""
        let password = self.password.text ?? ""
        self.authentication(email, password)
    }

    private func showAuthenticationError() {
        let dismiss = UIAlertAction(title: "OK", style: .Default) { (UIAlertAction) in
            self.dismissViewControllerAnimated(true, completion: nil)
        }

        let alert = UIAlertController(title: "Authentication Failed",
                                      message: "Wrong email/password",
                                      preferredStyle: .Alert)

        alert.addAction(dismiss)

        presentViewController(alert, animated: true, completion: nil)
    }
}
