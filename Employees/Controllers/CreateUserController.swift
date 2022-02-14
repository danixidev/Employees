
import UIKit
import Alamofire

class CreateUserController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var user: User?
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var salaryTextField: UITextField!
    @IBOutlet weak var biographyTextField: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var createUserButton: UIButton!
    
    
    var colorsArray = ["Empleado"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.dataSource = self
        pickerView.delegate = self
        createUserButton.layer.cornerRadius = 10.0
        
        if user?.job == "executive" {
            colorsArray = ["Empleado", "Recursos humanos", "Ejecutivo"]
        } else {
            colorsArray = ["Empleado", "Recursos humanos"]
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let tempArr = colorsArray
        return tempArr.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let tempArr = colorsArray
        return tempArr[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerView.reloadAllComponents()
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    @IBAction func createUserButton(_ sender: Any) {
        if nameTextField.text == "" {
            let alert = UIAlertController(title: "Error", message: "No has introducido un nombre", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else if emailTextField.text == "" {
            let alert = UIAlertController(title: "Error", message: "No has introducido un email", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else if salaryTextField.text == "" {
            let alert = UIAlertController(title: "Error", message: "No has introducido un salario", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else if biographyTextField.text == "" {
            let alert = UIAlertController(title: "Error", message: "No has introducido una biografia", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            var job: String?
            switch colorsArray[pickerView.selectedRow(inComponent: 0)] {
            case "Empleado":
                job = "employee"
                break
            case "Recursos humanos":
                job = "humanresources"
                break
            case "Ejecutivo":
                job = "executive"
                break
            default:
                job = "employee"
            }

            let salary = Int(salaryTextField.text!)

            if salary != nil {
                let newUser: Parameters = ["name": nameTextField.text!, "email": emailTextField.text!, "job": job!, "salary": salary!, "biography": biographyTextField.text!]
                
                if let user = user {
                    NetworkingHelper().createUserRequest(success: { msg in
                        let alert = UIAlertController(title: "Usuario creado", message: "Usuario creado correctamente", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: { action in
                            self.dismiss(animated: true, completion: nil)
                        }))
                        self.present(alert, animated: true, completion: nil)
                    }, failure: { msg in
                        let alert = UIAlertController(title: "Error", message: msg, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }, token: user.api_token!, user: newUser)
                }
            }
        }
    }
}
