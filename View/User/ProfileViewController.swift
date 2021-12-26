//
//  DarkModeViewController.swift
//  showapp
//
//  Created by rami on 8/11/2021.
//
import Foundation
import UIKit
import FBSDKLoginKit
import Alamofire
import SwiftUI

class ProfileViewController: UIViewController {
    var languages = [("English","en"),("French","fr")]
    
    @IBOutlet var darkmodeSwitch: UISwitch!

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var nom: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateProfile()
        let name = Notification.Name("updateProfil")
               NotificationCenter.default.addObserver(self, selector: #selector(updateProfile), name: name, object: nil)
        //self.setupPicker()
        
    }
    
    @objc func updateProfile(){
        nom.text = UserDefaults.standard.string(forKey: "firstName")
        email.text = UserDefaults.standard.string(forKey: "email")
        profileImage.imageFromServerURL(urlString: UserDefaults.standard.string(forKey: "profilePicture")!)
        
        
    }
    @IBAction func modifyProfile(_ sender: Any) {
        performSegue(withIdentifier: "profileModifySegue", sender: "yes")
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
    
    
    @IBAction func btnChangeLanguage(_ sender: Any) {
        let currentLang = Locale.current.languageCode
        print("currentLang: \(currentLang ?? "")")
        let newLanguage = currentLang == "en" ? "fr" : "en"
        UserDefaults.standard.setValue([newLanguage], forKey: "AppleLanguages")
        exit(0)
    }
    
    //test language picker
   /* var picker = UIPickerView()
    func setupPicker() {
        self.picker.backgroundColor = .gray
        self.picker = UIPickerView(frame: CGRect(x: 0, y:200, width: self.view.frame.width, height: 150))
        self.picker.delegate = self
        self.picker.dataSource = self
        //self.languageField.inputView = self.picker
    }*/
    
    
    
    
    
    


    
    
    

    
}

/*extension ProfileViewController : UIPickerViewDelegate,UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.languages.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.languages[row].0
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.languageField.text = self.languages[row]
    }
    
    
}*/


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

