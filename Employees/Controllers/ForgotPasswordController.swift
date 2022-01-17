
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
            let alert = UIAlertController(title: "Mail sent succesfully", message: "The mail was sent succesfully", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: { action in
                self.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }, failure: { msg in
            let alert = UIAlertController(title: "Error", message: msg, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }, parameters: ["email": emailTextField.text!])
    }
}
