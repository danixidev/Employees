
import UIKit
import Alamofire

class MainPageController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var user: User?
    var userSent: User?
    var users: [User?]?
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        refreshControl.addTarget(self, action: #selector(endRefresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        getAllUsers()
    }
    
    override func unwind(for unwindSegue: UIStoryboardSegue, towards subsequentVC: UIViewController) {
        getAllUsers()
    }
    
    @objc func endRefresh(refreshControl: UIRefreshControl) {
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        userSent = (users?[indexPath.row])!
        self.performSegue(withIdentifier: "detailsSegue", sender: nil)
    }
    
    func getAllUsers() {
        
        NetworkingHelper().getUsersRequest(success: { users in
            
            self.users = users
            self.tableView.reloadData()
            
            if self.refreshControl.isRefreshing {
                self.refreshControl.endRefreshing()
            }
            
            
        }, failure: { error in
            let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            if self.refreshControl.isRefreshing {
                self.refreshControl.endRefreshing()
            }
        }, headers: ["Token": (self.user?.api_token)!])
        
    }
    @IBAction func profileButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "profileSegue", sender: nil)
    }
    @IBAction func createUserButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "createUserSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "profileSegue" {
            let destination = segue.destination as! ProfilePageController
            destination.user = user
        } else if segue.identifier == "detailsSegue" {
            let destination = segue.destination as! ProfilePageController
            destination.user = userSent
        } else if segue.identifier == "createUserSegue" {
            let destination = segue.destination as! CreateUserController
            destination.user = user
        }
    }
}
