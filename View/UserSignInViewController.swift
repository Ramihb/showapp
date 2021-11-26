//
//  UserSignInViewController.swift
//  showapp
//
//  Created by rami on 15/11/2021.
//

import UIKit
import Alamofire

class UserSignInViewController: UIViewController {
    
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var emailAdressTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    
    
    @IBAction func continueClick(_ sender: Any) {
        if(emailAdressTextField.text != "" && passwordTextField.text != "" && phoneNumberTextField.text != "" && firstNameTextField.text != "" && lastNameTextField.text != ""){
                   AddUser(firstName: firstNameTextField.text!, lastName: lastNameTextField.text!, email: emailAdressTextField.text!, password: passwordTextField.text!, phoneNumber: phoneNumberTextField.text!)
                   self.navigationController?.popViewController(animated: true)
                   NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
               }else{
                   let alert = UIAlertController(title: "Warning", message: "You must fill all the fields", preferredStyle: .alert)
                   let action = UIAlertAction(title: "OK", style: .cancel)
                   alert.addAction(action)
                   self.present(alert, animated: true)
               }

        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    
    
    
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    func AddUser(firstName: String, lastName: String, email: String, password: String, phoneNumber: String) {
            let url = "http://172.27.32.1:3000/users/signup"
        let params: Parameters = [
            "email": emailAdressTextField.text!,
            "password": passwordTextField.text!,
            "phoneNumber": phoneNumberTextField.text!,
            "firstName": firstNameTextField.text!,
            "lastName": lastNameTextField.text!
        ]
            
            
            AF.request(url, method: .post,parameters: params)
                .validate()
                .responseJSON { response in
                    switch response.result {
                        case .success:
                            print("Validation Successful")
                        case .failure(let error):
                            print(error)
                    }
                }
    }
}
