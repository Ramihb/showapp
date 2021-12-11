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

        // Do any additional setup after loading the view.
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
