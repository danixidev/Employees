
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
    
    @IBAction func loginButton(_ sender: UIButton) {
        if emailTextEdit.text == "" {
            
        } else if passwordTextEdit.text == "" {
            
        } else {
            performSegue(withIdentifier: "loginSegue", sender: nil)
        }
    }
    
    func login(email: String, password: String) -> Bool {       // T{hiz>#pl(
        let parameters: Parameters = ["email": email, "password": password]
        var bool = false
        
        AF.request("http://kurokiji.com/api/login", method: .put, parameters: parameters).responseDecodable(of: Body.self) { response in
            if response.value?.status == 1 {
                print(response.value?.user!)
                print("Succesful: \(response.value?.msg)")
                bool = true
            } else {
                print("Failed: \(response.value?.msg)")
            }
        }
        return bool
    }
    func logout(token: String) -> Bool {
        let header: HTTPHeaders = ["token": token]
        var bool = false
        
        AF.request("http://kurokiji.com/api/employee/logout", method: .put, headers: header).responseDecodable(of: Body.self) { response in
            if(response.value?.status == 1) {
                print("Succesful: \(response.value?.msg)")
                bool = true
            } else {
                print("Failed: \(response.value?.msg)")
            }
        }
        return bool
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
