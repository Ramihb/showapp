//
//  UserSignInViewController.swift
//  showapp
//
//  Created by rami on 15/11/2021.
//
import CoreData
import UIKit
import Alamofire
import SendBirdUIKit

class UserSignInViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var emailAdressTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    
    
    @IBAction func continueClick(_ sender: Any) {
        if(emailAdressTextField.text != "" && passwordTextField.text != "" && phoneNumberTextField.text != "" && firstNameTextField.text != "" && lastNameTextField.text != ""){
                    if(passwordTextField.text! == confirmPasswordTextField.text!){
                        if isValidEmail(emailAdressTextField.text!){
                            if(phoneNumberTextField.text!.count == 8) {
//                                UserDefaults.standard.setValue(passwordTextField.text!, forKey: "mdp")
//                                UserDefaults.standard.setValue(passwordTextField.text!, forKey: "mail")
                                insertItem(mail: emailAdressTextField.text!, mdp: passwordTextField.text!)
                                let params: Parameters = [
                                            "email": emailAdressTextField.text!,
                                            "password": passwordTextField.text!,
                                            "phoneNumber": phoneNumberTextField.text!,
                                            "firstName": firstNameTextField.text!,
                                            "lastName": lastNameTextField.text!,
                                        ]
                                ApiMouchService.uploadImageToServer(image: imageView.image!, parameters: params)
                                //print("id:", UserDefaults.standard.string(forKey: "_id")!)
                               /* SendBirdApi().SendBirdCreateAccount(user_id: UserDefaults.standard.string(forKey: "_id")!, nickname:  UserDefaults.standard.string(forKey: "firstName")!, profile_url:  UserDefaults.standard.string(forKey: "profilePicture")!)*/
                                
                                                                                        self.performSegue(withIdentifier: "connexion", sender: "yes")
                            }else{
                                print("invalid phone number")
                                self.alert(title: "Warning", message: "invlaid phone number")
                            }
                            
                        }
                        else{
                            print("mail existant")
                        }
                        
                        
                    } else{
                        self.alert(title: "Warning", message: "mismatch password")
                    }
            
                }
    }
    struct Response: Decodable {
        let message: String
    }
    func finishPost (message:String, data:Data?) -> Void
    {
        do
        {
            if let jsonData = data
            {
                let parsedData = try JSONDecoder().decode(Response.self, from: jsonData)
                print(parsedData)
            }
        }
        catch
        {
            print("Parse Error: \(error)")
        }
    }
    
    
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
    
    func isValidEmail(_ email: String) -> Bool {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            
            let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailPred.evaluate(with: email)
        }
    
    
    
    
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
  
    
    
    
    
    
    
    
    
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func addImagePress(_ sender: Any) {
        
        let ac = UIAlertController(title: "Select Image", message: "Select image from?", preferredStyle: .actionSheet)
        let cameraBtn = UIAlertAction(title: "Camera", style: .default) {[weak self] (_) in
            self?.showImagePicker(selectedSource: .camera)
        }
        let libraryBnt = UIAlertAction(title: "Library", style: .default) {[weak self] (_) in
            self?.showImagePicker(selectedSource: .photoLibrary)
    }
        let CancelBtn = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        ac.addAction(cameraBtn)
        ac.addAction(libraryBnt)
        ac.addAction(CancelBtn)
        self.present(ac, animated: true, completion: nil)
    }
    
    
    func showImagePicker(selectedSource: UIImagePickerController.SourceType){
        guard UIImagePickerController.isSourceTypeAvailable(selectedSource) else{
            print("Selected Source not available")
            return
        }
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = selectedSource
        imagePickerController.allowsEditing = false
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            imageView.image = selectedImage
            
        }else{
            print("Image not found")
        }
        picker.dismiss(animated: true, completion: nil)
}
    
    
    
    
    
    func alert(title:String, message:String){
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .destructive , handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    
    func insertItem(mail: String, mdp: String) {
        self.deleteAllData("UserInfo")
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let persistentContainer = appDelegate.persistentContainer
            let managedContext = persistentContainer.viewContext
            
            
            let entityDescription = NSEntityDescription.entity(forEntityName: "UserInfo", in: managedContext)
            let object = NSManagedObject.init(entity: entityDescription!, insertInto: managedContext)
            
        object.setValue(emailAdressTextField.text!, forKey: "userMail")
        object.setValue(passwordTextField.text!, forKey: "userMdp")
        print("blabla1",object.value(forKey: "userMail")!)
        do {
                    
                    try managedContext.save()
                    print("c bon")
            print("blabla",object.value(forKey: "userMail")!)
            print(object.value(forKey: "userMdp")!)
                    
                } catch {
                    
                    print("dosen't work")
                }



        }
    
    func deleteAllData(_ entity:String)
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let persistentContainer = appDelegate.persistentContainer
                let managedContext = persistentContainer.viewContext
                
                
                let request = NSFetchRequest<NSManagedObject>(entityName: "UserInfo")
                
                do {
                    
                    let data = try managedContext.fetch(request)
                    for item in data {
                        
                        guard let objectData = item as? NSManagedObject else {continue}
                        managedContext.delete(objectData)
                    }
                    
                } catch  {
                    
                    print("Detele all data in \(entity) error :", error)
                }
                
            }
    
    
    
}
