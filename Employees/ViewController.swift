
import UIKit
import Alamofire

class ViewController: UIViewController {

    var users: [User]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUsers()
    }
    
    func getUsers() {
        AF.request("http://kurokiji.com/").responseDecodable(of: [User].self) { response in
            
            self.users = try? response.result.get()
            
            print(self.users!)
        }
    }


}

struct User: Codable {
    let user: String
    let pass: Int
}
