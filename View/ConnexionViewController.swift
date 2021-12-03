//
//  ProfileViewController.swift
//  showapp
//
//  Created by rami on 15/11/2021.
//

import UIKit
import GoogleSignIn
import FBSDKLoginKit
import Alamofire


class ConnexionViewController: UIViewController, LoginButtonDelegate {
    
    var faza = UIImage(named: "")
    
    @IBOutlet weak var emailAdressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var CompanySwitch: UISwitch!
    
    
    
    @IBAction func continueBtn(_ sender: Any) {
        if(emailAdressTextField.text != "" && passwordTextField.text != "" && CompanySwitch.isOn
         == false){
            LoginUser(email: emailAdressTextField.text!, password: passwordTextField.text!)
            
                   self.navigationController?.popViewController(animated: true)
                   NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        }else if(emailAdressTextField.text != "" && passwordTextField.text != "" && CompanySwitch.isOn == true ) {
            LoginCompany(email: emailAdressTextField.text!, password: passwordTextField.text!)
                   self.navigationController?.popViewController(animated: true)
                   NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
               }else{
                   let alert = UIAlertController(title: "Warning", message: "You must fill all the fields", preferredStyle: .alert)
                   let action = UIAlertAction(title: "OK", style: .cancel)
                   alert.addAction(action)
                   self.present(alert, animated: true)
            
  

               }
         

    }
    func LoginUser(email: String, password: String) {
        guard let url = URL(string: "http://172.27.32.1:3000/users/login") else {
            fatalError("Error getting the url")
        }
        let params: Parameters = [
            "email": emailAdressTextField.text!,
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
                            }

                        }
                        let token = response["token"]
                        
                        UserDefaults.standard.setValue(response["token"]!, forKey: "token")
//                        UserDefaults.standard.setValue(response["userId"]!, forKey: "userId")
                            print("Validation Successful")
                        self.performSegue(withIdentifier: "signinhomesegue", sender: "yes")
                        case .failure(let error):
                        self.prompt(title: "Echec", message: "Email ou mot de passe incorrect")
                        if let data = response.data {
                            let json = String(data: data, encoding: String.Encoding.utf8)
                            print("Failure Response: \(json)")
                        }
                        
                        
                    }
                }
    }
    
    
    func LoginCompany(email: String, password: String) {
        guard let url = URL(string: "http://172.27.32.1:3000/company/login") else {
            fatalError("Error getting the url")
        }
        let params: Parameters = [
            "emailCompany": emailAdressTextField.text!,
            "passwordCompany": passwordTextField.text!

        ]


            AF.request(url, method: .post,parameters: params)
                .validate()
                .responseJSON { response in
                    switch response.result {
                        case .success (let json):

                        let response = json as! NSDictionary
                        if let faza = response["Company"] as? [String: Any]{
                            for(key, value) in faza{
                                UserDefaults.standard.setValue(value, forKey: key)
                            }

                        }
                        let token = response["token"]
                        
                        UserDefaults.standard.setValue(response["token"]!, forKey: "token")
//                        UserDefaults.standard.setValue(response["userId"]!, forKey: "userId")
                            print("Validation Successful")
                        self.performSegue(withIdentifier: "companyStoryBoardSegue", sender: "yes")
                        case .failure(let error):
                        self.prompt(title: "Echec", message: "Email ou mot de passe incorrect")
                        if let data = response.data {
                            let json = String(data: data, encoding: String.Encoding.utf8)
                            print("Failure Response: \(json)")
                        }
                        
                        
                    }
                }
    }
    

    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        getUserDataFromFacebook()
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        
    }
    
    
    @IBOutlet weak var EmailAdress: UITextField!
    
    @IBOutlet weak var Password: UITextField!
    
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        facebookLoginButton.delegate = self
                facebookLoginButton.isHidden = true
        // Do any additional setup after loading the view.
        //fetchData()
        
    }
    
   
    
   
    
    
    @IBAction func signUp(_ sender: Any) {
        performSegue(withIdentifier: "signUpSegue", sender: "yes")
        
    }
    
    
    //google
    func getUserDataFromGoogle (){
            let signInConfig = GIDConfiguration.init(clientID: "280752879728-vofjf8m8g5h6u9vr188i4fp8m06fiopd.apps.googleusercontent.com")
            
            GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { userG, error in
              guard error == nil else { return }
            // print(userG)
              //  print(userG?.profile?.imageURL(withDimension: 512))
                //test
                let user = User(id: "", email: (userG?.profile!.email)!, password: "", profilePicture: "", firstName: (userG?.profile?.familyName)!, lastName: (userG?.profile?.givenName)!,isVerified: false,__v: 0)

                if let dataPhoto = try? Data(contentsOf: (userG?.profile?.imageURL(withDimension: 512))!) {
                    self.faza = UIImage(data: dataPhoto)
                            
                            }
                            ServiceUser().loginWithGoogleAndFacebook(email: user.email) { succes, reponse in
                                if succes, let json = reponse as? String{
                                    self.performSegue(withIdentifier: "signinhomesegue", sender: reponse)
                                    if json == "pas inscrit" {
                                        print("pas inscrit avec facebook")
                                    }
                                    
                                }
                                
                                else{
                                    
                                    ServiceUser().CreationCompteFacebookOrGoogle(user: user, image: self.faza! ) { succes, reponse in
                                        if succes, let json = reponse{
                                            if (json == "ok"){
                                                self.performSegue(withIdentifier: "signinhomesegue", sender: reponse)
                                            }
                                        }
                                        else if (reponse == "mail existant"){
//                                            self.propmt(title: "Echec", message: "Mail deja Existant")
                                            
                                        }
                                    }
                                }
                                
                                
                            }
                        }
    }
                //test
                    
//                self.performSegue(withIdentifier: "signinhomesegue", sender: "yes")
//            }
//        }


    @IBAction func logingoogle(_ sender: Any) {
        getUserDataFromGoogle()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let token = AccessToken.current, !token.isExpired{
            
                    performSegue(withIdentifier: "signinhomesegue", sender: "yes")
            
                }
    }
    
    
    
    
    
    //facebook
    let facebookLoginButton = FBLoginButton(frame: .zero, permissions: [.publicProfile,.email])
    
    
    @IBAction func loginfacebook(_ sender: Any) {
        facebookLoginButton.sendActions(for: .touchUpInside)
    }
    
    func getUserDataFromFacebook() {

            	

            GraphRequest(graphPath: "me", parameters: ["fields": "first_name,last_name, picture,email, id"]).start { (connection, result, error) in

                if let err = error { print(err.localizedDescription); return } else {

                    if let fields = result as? [String:Any],let lastname = fields["last_name"] as? String,let firstName = fields["first_name"] as? String,let email = fields["email"] as? String, let id = fields["id"] as? String {

                        var facebookProfileUrl = NSURL(string: "https://graph.facebook.com/\(id)/picture?type=large")
                        UserDefaults.standard.setValuesForKeys([lastname : "nom"])
                        UserDefaults.standard.setValuesForKeys([firstName : "prenom"])
                        UserDefaults.standard.setValuesForKeys([email : "email"])
                        
                        print("variable recherche   ",facebookProfileUrl)

                        if let data = NSData(contentsOf: facebookProfileUrl! as URL) {

                            print("variable recherche   ",data)
                            print("facebook connecter")
                            

                        }

                        
                    }

                }
                self.performSegue(withIdentifier: "signinhomesegue", sender: "yes")
            }
        }

    
    
    
    
    func fetchData() {
        guard let url = URL(string: "http://172.27.32.1:3000/users") else { return}
        let session = URLSession.shared.dataTask(with: url) {
            data, response, error in
            if let error = error {
                print("There was an error: \(error.localizedDescription)")
            } else {
                let jsonRes = try? JSONSerialization.jsonObject(with: data!, options: [])
                print("the response: \(jsonRes)")
            }
        }.resume()
        }

    func fetchCompanyData() {
        guard let url = URL(string: "http://172.27.32.1:3000/company") else { return}
        let session = URLSession.shared.dataTask(with: url) {
            data, response, error in
            if let error = error {
                print("There was an error: \(error.localizedDescription)")
            } else {
                let jsonRes = try? JSONSerialization.jsonObject(with: data!, options: [])
                print("the response: \(jsonRes)")
            }
        }.resume()
        }

    func prompt(title:String, message:String){
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .destructive , handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
}
