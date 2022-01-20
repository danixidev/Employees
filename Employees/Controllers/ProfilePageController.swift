
import UIKit
import Alamofire

class ProfilePageController: UIViewController {
    
    var user: User?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var roleLabel: UILabel!
    @IBOutlet weak var salaryLabel: UILabel!
    @IBOutlet weak var descriptionText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUser()
    }
    
    func loadUser() {
        if let user = user {
            nameLabel.text = user.name
            roleLabel.text = user.job
            
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.currencyCode = "EUR"
            let result = formatter.string(from: NSNumber(value: user.salary))
            
            salaryLabel.text = result
            descriptionText.text = user.biography
        }
    }
}
