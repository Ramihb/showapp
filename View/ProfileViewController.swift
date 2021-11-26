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


class ProfileViewController: UIViewController, LoginButtonDelegate {
    
    @IBOutlet weak var emailAdressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    
    @IBAction func continueBtn(_ sender: Any) {
                
        
    }
    
    var users = [String]()
    

    func login(email: String, password: String) {
            let url = "http://172.27.32.1:3000/users"
        let params: Parameters = [
            "email": emailAdressTextField.text!,
            "password": passwordTextField.text!,
            
        ]
            
            
            AF.request(url, method: .get,parameters: params)
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
        fetchData()
        
    }
    
   
    
   
    
    
    @IBAction func signUp(_ sender: Any) {
        performSegue(withIdentifier: "signUpSegue", sender: "yes")
        
    }
    
    
    //google
    func getUserDataFromGoogle (){
            let signInConfig = GIDConfiguration.init(clientID: "280752879728-vofjf8m8g5h6u9vr188i4fp8m06fiopd.apps.googleusercontent.com")
            
            GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { userG, error in
              guard error == nil else { return }
             print(userG)
                print(userG?.profile?.imageURL(withDimension: 512))
                
//                if let dataPhoto = try? Data(contentsOf: (userG?.profile?.imageURL(withDimension: 512))!) {
//                                 faza = UIImage(data: dataPhoto)
//                            }
//                            UserService().loginSocialMedia(username: user.email) { succes, reponse in
//                                if succes, let json = reponse as? String{
//                                    self.performSegue(withIdentifier: "connexion", sender: reponse)
//                                    if json == "pas inscrit" {
//                                        print("pas inscrit avec facebook")
//                                    }
//                                    
//                                }
//                                
//                                else{
//                                    
//                                    UserService().CreationCompteSocial(user: user, image: faza! ) { succes, reponse in
//                                        if succes, let json = reponse{
//                                            if (json == "ok"){
//                                                self.performSegue(withIdentifier: "connexion", sender: reponse)
//                                            }
//                                        }
//                                        else if (reponse == "mail existant"){
//                                            self.propmt(title: "Echec", message: "Mail deja Existant")
//                                            
//                                        }
//                                    }
//                                }
                
                    
                    
                self.performSegue(withIdentifier: "signinhomesegue", sender: "yes")
            }
        }


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


    
}
