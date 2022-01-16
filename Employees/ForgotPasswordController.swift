
import UIKit
import Alamofire

class ForgotPasswordController: UIViewController {

    @IBOutlet weak var sendMailButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sendMailButton.layer.cornerRadius = 8.0
    }
    
    func sendMail(email: String) -> Bool {
        let parameters: Parameters = ["email": email]
        var bool = false
        
        AF.request("http://kurokiji.com/api/passwordrecover", method: .put, parameters: parameters).responseDecodable(of: Body.self) { response in
            if(response.value?.status == 1) {
                print("Succesful: \(String(describing: response.value?.msg))")
                bool = true
            } else {
                print("Failed: \(String(describing: response.value?.msg))")
            }
        }
        return bool
    }
    
    @IBAction func sendMailButton(_ sender: UIButton) {
        if sendMail(email: emailTextField.text!) {
            //Mostrar mensaje de que compruebe la bandeja de entrada
        } else {
            //Avisar de que ha ocurrido un error
        }
    }
}
