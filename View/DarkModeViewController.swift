//
//  DarkModeViewController.swift
//  showapp
//
//  Created by rami on 8/11/2021.
//

import UIKit
import FBSDKLoginKit
import Alamofire
import SwiftUI

class DarkModeViewController: UIViewController {
    @IBOutlet var darkmodeSwitch: UISwitch!

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var nom: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let url = "http://172.27.32.1:3000/users"
//        fetchData(from: url)
        //display(userId: UserDefaults.standard.string(forKey: "userId")!)
        nom.text = UserDefaults.standard.string(forKey: "firstName")
        email.text = UserDefaults.standard.string(forKey: "email")
        profileImage.imageFromServerURL(urlString: UserDefaults.standard.string(forKey: "profilePicture")!)
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
        UserDefaults.standard.removeObject(forKey: "_id")
        UserDefaults.standard.removeObject(forKey: "email")
        UserDefaults.standard.removeObject(forKey: "firstName")
        UserDefaults.standard.removeObject(forKey: "lastName")
        UserDefaults.standard.removeObject(forKey: "password")
        UserDefaults.standard.removeObject(forKey: "profilePicture")
        UserDefaults.standard.removeObject(forKey: "verified")
        performSegue(withIdentifier: "logOutSegue", sender: "yes")
    }
    
    
    
    
    
    
    
    
    struct MyResult: Codable {
        let _id: String
        let email: String
        let password: String
        let profilePicture: String
        let firstName: String
        let lastName: String
        let verified: Bool
        let __v: Int
    }
    
    


    
    
    

    
}




extension UIImageView {
    public func imageFromServerURL(urlString: String) {
        self.image = nil
        let urlStringNew = urlString.replacingOccurrences(of: " ", with: "%20")
        URLSession.shared.dataTask(with: NSURL(string: urlStringNew)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error as Any)
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })
            
        }).resume()
    }}

