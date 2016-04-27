import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var login: UIButton!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    var user: User? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func perform(sender: AnyObject) {
        ActivityIndicator.show()
        let email = self.email.text ?? ""
        let password = self.password.text ?? ""
        
        authentication(email, password)
            .subscribe(onSuccess: { user in
                self.user = user
            }, onError: { error in
                print(error)
            }, onComplete: {
                ActivityIndicator.hide()
                self.checkUser()
            })
    }
    
    private func checkUser() {
        dispatch_sync(dispatch_get_main_queue()) {
            if self.user == nil {
                self.showAuthenticationError()
            } else {
                self.performSegueWithIdentifier("showAccount", sender: self)
            }
        }
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




