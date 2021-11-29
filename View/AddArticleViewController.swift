//
//  AddArticleViewController.swift
//  showapp
//
//  Created by rami on 15/11/2021.
//

import UIKit
import CoreData
import Alamofire
class AddArticleViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var Quantity: UITextField!
    @IBOutlet weak var NameAdd: UITextField!
    @IBOutlet weak var PriceAdd: UITextField!
    @IBOutlet weak var CategorieAdd: UITextField!
    @IBOutlet weak var LogoAdd: UIImageView!
    @IBOutlet weak var Typee: UITextField!
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func ButtonAddLogo(_ sender: Any) {
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
            LogoAdd.image = selectedImage
            
        }else{
            print("Image not found")
        }
        picker.dismiss(animated: true, completion: nil)
}
    @IBAction func buttonAddArticle(_ sender: Any) {
        if(NameAdd.text != "" && CategorieAdd.text != "" && PriceAdd.text != "" && Quantity.text != "" && Typee.text != ""){

            let params: Parameters = [
                "name": NameAdd.text!,
                "category": CategorieAdd.text!,
                "price": PriceAdd.text!,
                "quantity": Quantity.text!,
                "type": Typee.text!
                
            ]
            articleService.addArticleToServer(image: LogoAdd.image!, parameters: params)
            
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
    

    func AddArticle(firstName: String, lastName: String, email: String, password: String, phoneNumber: String) {
            let url = "http://172.27.32.1:3000/articles"
        let params: Parameters = [
            "name": NameAdd.text!,
            "category": CategorieAdd.text!,
            "price": PriceAdd.text!,
            "quantity": Quantity.text!,
            "type": Typee.text!
            
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
    
    
    
}
