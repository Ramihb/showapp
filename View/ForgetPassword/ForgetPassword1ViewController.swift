//
//  ForgetPassword1ViewController.swift
//  showapp
//
//  Created by rami on 9/12/2021.
//

import UIKit

class ForgetPassword1ViewController: UIViewController {
    
    var code = ""
    
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
    

    @IBAction func buttonConfirm(_ sender: Any) {
        ServiceUser().forgotPassword(email: emailTextField.text!) { success, reponse in
                    if success{
                        self.code = reponse! as! String
                    }

                }
        performSegue(withIdentifier: "emailToCodeSegue", sender: "yes")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "emailToCodeSegue" {
            
            let destination = segue.destination as! ForgetPassword2ViewController
            
            destination.email = emailTextField.text!
        }
    }

}
