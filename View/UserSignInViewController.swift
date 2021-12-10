//
//  UserSignInViewController.swift
//  showapp
//
//  Created by rami on 15/11/2021.
//

import UIKit
import Alamofire

class UserSignInViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var emailAdressTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    
    
    @IBAction func continueClick(_ sender: Any) {
        if(emailAdressTextField.text != "" && passwordTextField.text != "" && phoneNumberTextField.text != "" && firstNameTextField.text != "" && lastNameTextField.text != ""){

            let params: Parameters = [
                        "email": emailAdressTextField.text!,
                        "password": passwordTextField.text!,
                        "phoneNumber": phoneNumberTextField.text!,
                        "firstName": firstNameTextField.text!,
                        "lastName": lastNameTextField.text!,
                    ]
            ApiMouchService.uploadImageToServer(image: imageView.image!, parameters: params)
            
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

        // Do any additional setup after loading the view.
    }
    

    
    
    
    
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
   /* func AddUser(firstName: String, lastName: String, email: String, password: String, phoneNumber: String) {
            let url = "http://192.168.1.13:3000/users/signup"
        let params: Parameters = [
            "email": emailAdressTextField.text!,
            "password": passwordTextField.text!,
            "phoneNumber": phoneNumberTextField.text!,
            "firstName": firstNameTextField.text!,
            "lastName": lastNameTextField.text!
            
        ]
            
            
            AF.request(url, method: .post,parameters: params)
                .validate()
                .responseJSON { response in
                    switch response.result {
                        case .success:
                            print("Validation Successful")
                        case .failure(let error):
                            print(error)
                    }
                }
    }*/
    
    
    
    
    
    
    
    
    
    
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
}
