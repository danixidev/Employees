
import UIKit
import Alamofire

class ForgotPasswordController: UIViewController {

    @IBOutlet weak var sendMailButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sendMailButton.layer.cornerRadius = 8.0
    }
    
    @IBAction func sendMailButton(_ sender: UIButton) {
        
        NetworkingHelper().sendMailRequest(success: { msg in
            print(msg)
        }, failure: { msg in
            print(msg)
        }, parameters: ["email": emailTextField.text!])
    }
}
