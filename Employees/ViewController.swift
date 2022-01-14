
import UIKit
import Alamofire

class ViewController: UIViewController {

    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        login(email: "", password: "")
    }
    
    func login(email: String, password: String) {
        let parameters: Parameters = ["email": email, "password": password]
        
        AF.request("http://kurokiji.com/api/login", method: .put, parameters: parameters).responseDecodable(of: Body.self) { response in
            
            self.user = try? response.value?.user
            
            print(self.user!)
        }
    }


}

struct Body: Codable {
    let status: Int
    let msg: String
    let user: User
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
