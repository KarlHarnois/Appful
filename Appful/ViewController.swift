import UIKit

class ViewController: UIViewController, AuthenticationDelegate {
    
    @IBOutlet weak var login: UIButton!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    var authenticationManager: AuthenticationManager?
    var user: User?

    override func viewDidLoad() {
        super.viewDidLoad()
        print(user)
        authenticationManager = AuthenticationManager(delegate: self)
    }

    @IBAction func perform(sender: AnyObject) {
        ActivityIndicator.show()
        let email = self.email.text ?? ""
        let password = self.password.text ?? ""
        authenticationManager?.authentication(email, password)
    }
    
    func authenticationResult(user: User?) {
        ActivityIndicator.hide()
        self.user = user
        dispatch_sync(dispatch_get_main_queue()) {
            self.performSegueWithIdentifier("showAccount", sender: self)
        }
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        return user != nil
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destination = segue.destinationViewController as? AccountController {
            destination.user = self.user
        }
    }

    private func showAuthenticationError() {
        let dismiss = UIAlertAction(title: "OK", style: .Default){ _ in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        let alert = UIAlertController(title: "Authentication Failed",
                                                      message: "Wrong email/password",
                                                      preferredStyle: .Alert)
        alert.addAction(dismiss)
        presentViewController(alert, animated: true, completion: nil)
    }
}




