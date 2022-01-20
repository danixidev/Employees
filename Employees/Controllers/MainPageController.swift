
import UIKit
import Alamofire

class MainPageController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var user: User?
    var users: [User?]?
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        getAllUsers()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "celdaID", for: indexPath)
        celda.textLabel?.text = users?[indexPath.row]!.name
        return celda
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let users = users {
            return users.count
        } else {
            return 0
        }
    }
    
    func getAllUsers() {
        
        NetworkingHelper().getUsersRequest(success: { users in
            
            self.users = users
            self.tableView.reloadData()
            
        }, failure: { error in
            let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }, headers: ["Token": (self.user?.api_token)!])
        
    }
    @IBAction func profileButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "profileSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! ProfilePageController
        destination.user = self.user
    }
}
