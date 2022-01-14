
import UIKit
import Alamofire

class ViewController: UIViewController {

    var user: User?
    @IBOutlet weak var emailTextEdit: UITextField!
    @IBOutlet weak var passwordTextEdit: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        if emailTextEdit.text == "" {
            
        } else if passwordTextEdit.text == "" {
            
        } else {
            login(email: emailTextEdit.text!, password: passwordTextEdit.text!)
        }
    }
    
    func login(email: String, password: String) {       // T{hiz>#pl(
        let parameters: Parameters = ["email": email, "password": password]
        
        AF.request("http://kurokiji.com/api/login", method: .put, parameters: parameters).responseDecodable(of: Body.self) { response in
            if response.value?.status == 1 {
                print(response.value?.user)
                print("Succesful: \(response.value?.msg)")
            } else {
                print("Failed: \(response.value?.msg)")
            }
        }
    }
    func logout(token: String) {
        let header: HTTPHeaders = ["token": token]
        
        AF.request("http://kurokiji.com/api/employee/logout", method: .put, headers: header).responseDecodable(of: Body.self) { response in
            if(response.value?.status == 1) {
                print("Succesful: \(response.value?.msg)")
            } else {
                print("Failed: \(response.value?.msg)")
            }
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
