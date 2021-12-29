//
//  CompanyViewController.swift
//  showapp
//
//  Created by rami on 8/11/2021.
//

import UIKit
import Alamofire
import DropDown

class CompanyViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var businessNameTextField: UITextField!
    @IBOutlet weak var ContactNumberTextField: UITextField!
    @IBOutlet weak var emailCompanyTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var categoryTextField: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    let categoryDropDown = DropDown()
        let categoryValue = ["mode", "high tech", "beauty", "baby", "jewerly", "art deco"]
    @IBAction func showCategoryOptions(_ sender: Any) {
        categoryDropDown.show()
        }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @IBAction func registerBusiness(_ sender: Any) {
        if(firstNameTextField.text != "" && lastNameTextField.text != "" && businessNameTextField.text != "" && ContactNumberTextField.text != "" && emailCompanyTextField.text != "" && passwordTextField.text != "" && categoryTextField.text != "Select a category"){
            if isValidEmail(emailCompanyTextField.text!){
                if(ContactNumberTextField.text!.count == 8){
                    let params: Parameters = [
                        "emailCompany": emailCompanyTextField.text!,
                        "passwordCompany": passwordTextField.text!,
                        "phoneNumberCompany": ContactNumberTextField.text!,
                        "firstNameCompany": firstNameTextField.text!,
                        "lastNameCompany": lastNameTextField.text!,
                        "businessNameCompany": businessNameTextField.text!,
                        "categoryCompany": categoryTextField.text!
                    ]
                    ApiCompanyService.uploadImageToServer(image: imageView.image!, parameters: params)
                }
                else {
                    print("invalid phone number")
                                            self.alert(title: "Warning", message: "invlaid phone number")
                }
                
            } else {
                print("invalid mail")
            }
            
            
            
        } else {
            self.alert(title: "Warning", message: "please fill all the fields")
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
    func isValidEmail(_ email: String) -> Bool {
                let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
                
                let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
                return emailPred.evaluate(with: email)
            }
    
//    func AddCompany(firstNameCompany: String, lastNameCompany: String, emailCompany: String, passwordCompany: String, phoneNumberCompany: String, categoryCompany: String, businessNameCompany: String) {
//            let url = "http://192.168.1.23:3000/company/signup"
//        let params: Parameters = [
//            "emailCompany": emailCompanyTextField.text!,
//            "passwordCompany": passwordTextField.text!,
//            "phoneNumberCompany": ContactNumberTextField.text!,
//            "firstNameCompany": firstNameTextField.text!,
//            "lastNameCompany": lastNameTextField.text!,
//            "businessNameCompany": businessNameTextField.text!,
//            "categoryCompany": categoryTextField.text!
//        ]
//
//
//            AF.request(url, method: .post,parameters: params)
//                .validate()
//                .responseJSON { response in
//                    switch response.result {
//                        case .success:
//                            print("Validation Successful")
//                        case .failure(let error):
//                            print(error)
//                    }
//                }
//
//    }
    
    @IBOutlet weak var vwDropDown:UIView!
    
      
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryTextField.text = "Select a category"
                categoryDropDown.anchorView = vwDropDown
                categoryDropDown.dataSource = categoryValue
                categoryDropDown.bottomOffset = CGPoint(x: 0, y:(categoryDropDown.anchorView?.plainView.bounds.height)!)
                categoryDropDown.topOffset = CGPoint(x: 0, y:-(categoryDropDown.anchorView?.plainView.bounds.height)!)
                categoryDropDown.direction = .bottom
                categoryDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                  print("Selected item: \(item) at index: \(index)")
                    self.categoryTextField.text = categoryValue[index]
                }

        
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
    
    
    func alert(title:String, message:String){
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .destructive , handler: nil)
                alert.addAction(action)
                present(alert, animated: true, completion: nil)
            }
    

}
