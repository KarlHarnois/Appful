import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var login: UIButton!
  @IBOutlet weak var email: UITextField!
  @IBOutlet weak var password: UITextField!

  var isAuthenticated = false

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    /*
     * TODO: Pending implementation
     *
     * Show a welcome message on the next
     * screen with the user's first name
     */
  }

  override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
    return isAuthenticated
  }

  func authenticate() -> Bool {
    UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    let email = self.email.text ?? ""
    let password = self.password.text ?? ""
    fetchAuthenticationToken(email, password){ data, response, error in
        if let err = error {
            print(err)
            self.isAuthenticated = false
        } else if let jsonData = data, let currentResponse = response as? NSHTTPURLResponse {
            let result = try? NSJSONSerialization.JSONObjectWithData(jsonData, options: []) as? [String: AnyObject]
            if let jsonResult = result {
                let token = jsonResult!["token"] as? String
                let statusCode = currentResponse.statusCode
                print(token)
                print(statusCode)
            }
        }
    }
    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    return isAuthenticated
  }

  @IBAction func perform(sender: AnyObject) {
    if !authenticate() {
      showAuthenticationError()
    }
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
