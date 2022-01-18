
import UIKit
import Alamofire

class MainPageController: UIViewController {
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func getAllUsers() {
        
        NetworkingHelper().getUsersRequest(success: { users in
            
            print(users)
            
        }, failure: { error in
            let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }, headers: ["Token": (self.user?.api_token)!])
        
    }
}
