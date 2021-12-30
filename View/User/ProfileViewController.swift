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
import SendBirdUIKit

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
        user1 = SBUUser(userId: "61ca18c42e2609ccdeb2341b", nickname: "showapp", profileUrl: "http://192.168.1.14:3000/images/imagefile.jpg1640634563943.jpg")
                user2 = SBUUser(userId: UserDefaults.standard.string(forKey: "_id")!, nickname: UserDefaults.standard.string(forKey: "firstName")!, profileUrl: UserDefaults.standard.string(forKey: "profilePicture")!)
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
    var params = SBDUserMessageParams(message: "text")

        var channelURL = ""
        var user:User?
        var usersSB:[SBUUser]?
        var user1,user2,userMod: SBUUser?
    
    @IBAction func envoyerMessage(_ sender: Any) {
            SBDMain.connect(withUserId: UserDefaults.standard.string(forKey: "_id")!, completionHandler: { (user, error) in
                guard error == nil else {
                    print("erreur function : ",error)
                    return
                }
                            
            })
           
                SBDGroupChannel.createChannel(withUserIds: Array(arrayLiteral: self.user2!.userId,self.user1!.userId), isDistinct: true) { data, error in
                    
                    self.channelURL = data!.channelUrl
                    print("Created channel url : ",self.channelURL)
                }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                
                SBDGroupChannel.getWithUrl(self.channelURL) { openChannel, error in
                    print("Entering channel url",self.channelURL)
                    print("open channel : ",openChannel,"erreur : ", error)
                    guard let openChannel = openChannel, error == nil else {
                        return // Handle error.
                    }
                    openChannel.sendUserMessage("Hello") { reponse, error in
                    }
      
            }
            }
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

