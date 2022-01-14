
import UIKit
import Alamofire

class ViewController: UIViewController {

    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //login(email: "danixidev@gmail.com", password: "T{hiz>#pl(")
        logout(token: "$2y$10$rT0znvuWwS/6j/do5k/MI.6//Qy6k9ctlCfb7.3HCJyLSqjItH.Mq")
    }
    
    func login(email: String, password: String) {
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
