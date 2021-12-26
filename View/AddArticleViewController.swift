//
//  AddArticleViewController.swift
//  showapp
//
//  Created by rami on 15/11/2021.
//

import UIKit
import CoreData
import Alamofire
import DropDown
class AddArticleViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBOutlet weak var Quantity: UITextField!
    @IBOutlet weak var NameAdd: UITextField!
    @IBOutlet weak var PriceAdd: UITextField!
    @IBOutlet weak var LogoAdd: UIImageView!
    
    //Test Drop Down menu Category
    @IBOutlet weak var vwDropDown:UIView!
    @IBOutlet weak var Category:UILabel!
    
    
    let categoryDropDown = DropDown()
    let typeDropDown = DropDown()
    let categoryValue = ["mode", "high tech", "beauty", "baby", "jewerly", "art deco"]
    @IBAction func showCategoryOptions(_ sender: Any) {
        categoryDropDown.show()
    }
    
    //Test Drop Down menu Type
    @IBOutlet weak var vwDropDownType:UIView!
    @IBOutlet weak var Typee:UILabel!
    let typeValue = ["sweaters", "pants", "outlet", "jacket", "shoes",
                     "Dress", "Pc", "Tv", "Computers' accessories", "make-up", "Art Supplies", "jewerly", "art deco", "Other"
                 ]
    let typeMode = ["sweaters", "pants", "outlet", "jacket", "shoes",
                     "Dress"]
    let typeHighTech = ["Pc", "Tv", "Computers' accessories"]
    @IBAction func showTypeOptions(_ sender: Any) {
        typeDropDown.show()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Category
        Category.text = "Select a category"
        categoryDropDown.anchorView = vwDropDown
        categoryDropDown.dataSource = categoryValue
        categoryDropDown.bottomOffset = CGPoint(x: 0, y:(categoryDropDown.anchorView?.plainView.bounds.height)!)
        categoryDropDown.topOffset = CGPoint(x: 0, y:-(categoryDropDown.anchorView?.plainView.bounds.height)!)
        categoryDropDown.direction = .bottom
        categoryDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
            self.Category.text = categoryValue[index]
        }
            //Type
            Typee.text = "Select a type"
        typeDropDown.anchorView = vwDropDownType
        typeDropDown.dataSource = typeValue
        typeDropDown.bottomOffset = CGPoint(x: 0, y:(typeDropDown.anchorView?.plainView.bounds.height)!)
        typeDropDown.topOffset = CGPoint(x: 0, y:-(typeDropDown.anchorView?.plainView.bounds.height)!)
        typeDropDown.direction = .bottom
        typeDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
              print("Selected item: \(item) at index: \(index)")
                self.Typee.text = typeValue[index]
        
        }
        
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
        if(NameAdd.text != "" && Category.text != "" && PriceAdd.text != "" && Quantity.text != "" && Typee.text != ""){

            let params: Parameters = [
                "brand": UserDefaults.standard.string(forKey: "_id")!,
                "name": NameAdd.text!,
                "category": Category.text!,
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
            let url = "http://172.31.32.1:3000/articles"
        let params: Parameters = [
            "name": NameAdd.text!,
            "category": Category.text!,
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
