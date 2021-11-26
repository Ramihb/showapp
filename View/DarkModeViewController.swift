//
//  DarkModeViewController.swift
//  showapp
//
//  Created by rami on 8/11/2021.
//

import UIKit
import FBSDKLoginKit

class DarkModeViewController: UIViewController {
    @IBOutlet var darkmodeSwitch: UISwitch!

    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var nom: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
    }
    
    
    @IBAction func switchToDarkMode(_sender: UISwitch) {
    
        if _sender.isOn {
            UIApplication.shared.windows.forEach{
                window in window.overrideUserInterfaceStyle = .dark
            }}else{
                UIApplication.shared.windows.forEach{ window in window.overrideUserInterfaceStyle = .light
            }
            } }
    
    
    
    @IBAction func logOutbutton(_ sender: Any) {
        var loginManager = LoginManager()
        loginManager.logOut()
        performSegue(withIdentifier: "logOutSegue", sender: "yes")
    }
    
}

