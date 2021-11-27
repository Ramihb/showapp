//
//  CompanyViewController.swift
//  showapp
//
//  Created by rami on 8/11/2021.
//

import UIKit
import Alamofire

class CompanyViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var businessNameTextField: UITextField!
    @IBOutlet weak var ContactNumberTextField: UITextField!
    @IBOutlet weak var emailCompanyTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func registerBusiness(_ sender: Any) {
        if(firstNameTextField.text != "" && lastNameTextField.text != "" && businessNameTextField.text != "" && ContactNumberTextField.text != "" && emailCompanyTextField.text != "" && passwordTextField.text != "" && categoryTextField.text != ""){
            AddCompany(firstNameCompany: firstNameTextField.text!, lastNameCompany: lastNameTextField.text!, emailCompany: emailCompanyTextField.text!, passwordCompany: passwordTextField.text!, phoneNumberCompany: ContactNumberTextField.text!, categoryCompany: categoryTextField.text!, businessNameCompany: businessNameTextField.text!)
                   self.navigationController?.popViewController(animated: true)
                   NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
               }else{
                   let alert = UIAlertController(title: "Warning", message: "You must fill all the fields", preferredStyle: .alert)
                   let action = UIAlertAction(title: "OK", style: .cancel)
                   alert.addAction(action)
                   self.present(alert, animated: true)
               }
        
        
        
    }
    
    
    func AddCompany(firstNameCompany: String, lastNameCompany: String, emailCompany: String, passwordCompany: String, phoneNumberCompany: String, categoryCompany: String, businessNameCompany: String) {
            let url = "http://172.27.32.1:3000/company/signup"
        let params: Parameters = [
            "emailCompany": emailCompanyTextField.text!,
            "passwordCompany": passwordTextField.text!,
            "phoneNumberCompany": ContactNumberTextField.text!,
            "firstNameCompany": firstNameTextField.text!,
            "lastNameCompany": lastNameTextField.text!,
            "businessNameCompany": businessNameTextField.text!,
            "categoryCompany": categoryTextField.text!,
            "brandPicCompany": "gggggg"
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
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


        
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
            imageView.image = selectedImage
            
        }else{
            print("Image not found")
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    
    

}
