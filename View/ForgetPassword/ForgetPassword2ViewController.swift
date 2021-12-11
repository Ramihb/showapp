//
//  ForgetPassword2ViewController.swift
//  showapp
//
//  Created by rami on 10/12/2021.
//

import UIKit

class ForgetPassword2ViewController: UIViewController {

    @IBAction func backButton(_ sender: Any) {
                self.dismiss(animated: true, completion: nil)
            }
    
    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    var email:String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func confirmButton(_ sender: Any) {
        if(passwordTextField.text! == confirmPasswordTextField.text!){
            ServiceUser().resetPass(password: passwordTextField.text!, email: email!, code: codeTextField.text!) { succes, reponse in
        if succes{
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "forgetPasswordToConnexionSegue", sender: nil)
            }
            
        } else {
            print("erreur in changing password")
        }
    }
        }
        //alert mismatch password
        else{
            self.alert(title: "Echec", message: "mismatch password")
        }
}



    func alert(title:String, message:String){
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .destructive , handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }

}
