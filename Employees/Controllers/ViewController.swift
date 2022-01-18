
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
                let alert = UIAlertController(title: "Login succesful", message: "User was logged in succesfully", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: { action in
                    self.user = user!
                    print(user)
                    
                    UserDefaults.standard.set(self.user?.api_token, forKey: "api_token")
                    
                    self.performSegue(withIdentifier: "loginSegue", sender: nil)
                }))
                self.present(alert, animated: true, completion: nil)
            }, failure: { error in
                let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }, parameters: ["email": emailTextEdit.text!, "password": passwordTextEdit.text!])
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! MainPageController
        destination.user = self.user
    }
}

    
struct Response: Decodable, Encodable {
    let status: Int
    let msg: String
    let user: User?
    let data: [User]?
}

struct User: Decodable, Encodable {
    let id: Int?
    let name: String
    let email: String
    let job: String
    let salary: Float
    let biography: String
    let profileImgUrl: String
    let api_token: String?
}
