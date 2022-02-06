//
//  LoginAdminViewController.swift
//  showapp
//
//  Created by rami on 28/12/2021.
//

import UIKit
import Alamofire
import SendBirdUIKit
import SendBirdSDK
class LoginAdminViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

          //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
          //tap.cancelsTouchesInView = false
          view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

   
    @IBAction func LoginAdminButton(_ sender: Any) {
        if(emailTextField.text != "" && passwordTextField.text != ""){
            LoginAdmin(email: emailTextField.text!, password: passwordTextField.text!)
            self.navigationController?.popViewController(animated: true)
                               NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        }else{
            let alert = UIAlertController(title: "Warning", message: "You must fill all the fields", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel)
            alert.addAction(action)
            self.present(alert, animated: true)
     


        }
    }
    func LoginAdmin(email: String, password: String) {
            guard let url = URL(string: "http://172.17.2.21:3000/admin/login") else {
                fatalError("Error getting the url")
            }
            let params: Parameters = [
                "email": emailTextField.text!,
                "password": passwordTextField.text!

            ]


                AF.request(url, method: .post,parameters: params)
                    .validate()
                    .responseJSON { response in
                        switch response.result {
                            case .success (let json):

                            let response = json as! NSDictionary
                            if let faza = response["user"] as? [String: Any]{
                                for(key, value) in faza{
                                    UserDefaults.standard.setValue(value, forKey: key)
                                    print("test:",UserDefaults.standard.string(forKey: "_id"))
                                }
                                SBUGlobals.CurrentUser = SBUUser(userId: UserDefaults.standard.string(forKey: "_id")!)
                                print("Validation Successful")
                            self.performSegue(withIdentifier: "loginToAdmin", sender: "yes")
                            }
                            
                            /*let token = response["token"]
                            
                            UserDefaults.standard.setValue(response["token"]!, forKey: "token")*/
    //                        UserDefaults.standard.setValue(response["userId"]!, forKey: "userId")
                                
                            case .failure(let error):
                            self.prompt(title: "Echec", message: "Email ou mot de passe incorrect")
                            if let data = response.data {
                                let json = String(data: data, encoding: String.Encoding.utf8)
                                print("Failure Response: \(json)")
                            }
                            
                            
                        }
                    }
        }
    func prompt(title:String, message:String){
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .destructive , handler: nil)
                alert.addAction(action)
                present(alert, animated: true, completion: nil)
            }
}
