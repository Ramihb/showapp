//
//  ModifierProfileViewController.swift
//  showapp
//
//  Created by rami on 3/12/2021.
//
import Foundation
import UIKit
import Alamofire


class ModifierProfileViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
        @IBOutlet weak var name: UITextField!
        @IBOutlet weak var email: UITextField!
        @IBOutlet weak var profilePicture: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
       
        name.text = UserDefaults.standard.string(forKey: "firstName")
        email.text = UserDefaults.standard.string(forKey: "phoneNumber")
        profilePicture.imageFromServerURL(urlString: UserDefaults.standard.string(forKey: "profilePicture")!)
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

                  //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
                  //tap.cancelsTouchesInView = false
                  view.addGestureRecognizer(tap)
            }
            
            @objc func dismissKeyboard() {
                //Causes the view (or one of its embedded text fields) to resign the first responder status.
                view.endEditing(true)
            }
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true)
    }

    @IBAction func ConfirmButton(_ sender: Any) {
    
        
        let params: Parameters = [
                                "_id": UserDefaults.standard.string(forKey: "_id")!,
                                "email":    UserDefaults.standard.string(forKey: "email")!,
                                "password": UserDefaults.standard.string(forKey: "password")!,
                                "firstName": name.text!,
                                "lastName": UserDefaults.standard.string(forKey: "lastName")!,
                                "phoneNumber": email.text!
                            ]
        test.uploadImageToServer(image: profilePicture.image!, parameters: params){ succes, reponse in
            if succes, let json = reponse{
                let name = Notification.Name("updateProfil")
                let notification = Notification(name: name)
                NotificationCenter.default.post(notification)
                self.dismiss(animated: true)
            }
            else{
                //print(reponse)
            }
             }
        
                        
                       /* let pictureUrl = NSURL(string: UserDefaults.standard.string(forKey: "profilePicture")!)
                    print(user!)
                        let imageData = NSData(contentsOf: pictureUrl! as URL)
                        let faza = UIImage(data: imageData as! Data)
                    ServiceUser().UpdateProfil(user: user!, image: profilePicture.image!) { succes, reponse in
                                if succes, let json = reponse{
                                    let name = Notification.Name("updateProfil")
                                    let notification = Notification(name: name)
                                    NotificationCenter.default.post(notification)
                                    self.dismiss(animated: true)
                                }
                                else{
                                    //print(reponse)
                                }
                            }*/
                         
    }
    
    
        
        
        
    
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
                profilePicture.image = selectedImage
                
            }else{
                print("Image not found")
            }
            picker.dismiss(animated: true, completion: nil)
    }

}
