
import UIKit
import Alamofire

class ViewController: UIViewController {

    var user: User?
    @IBOutlet weak var emailTextEdit: UITextField!
    @IBOutlet weak var passwordTextEdit: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.cornerRadius = 10.0
    }
    
    @IBAction func loginButton(_ sender: UIButton) {    // rf;^])
        if emailTextEdit.text == "" {
            
        } else if passwordTextEdit.text == "" {
            
        } else {
            NetworkingHelper().loginRequest(success: { user in
                print(user)
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }, failure: { error in
                print(error)
            }, parameters: ["email": emailTextEdit.text!, "password": passwordTextEdit.text!])
        }
    }

}
    
struct Body: Codable {
    let status: Int
    let msg: String
    let user: User?
}

struct User: Codable {
    let id: Int
    let name: String
    let email: String
    let job: String
    let salary: Int
    let biography: String
    let profileImgUrl: String
}
