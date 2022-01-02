//
//  CompanyNewsViewController.swift
//  showapp
//
//  Created by rami on 15/11/2021.
//

import UIKit
import Alamofire

class CompanyNewsViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBAction func back(_ sender: Any) {
            self.dismiss(animated: true)
        }
    
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsTitleTextField: UITextField!
    

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
    

    @IBAction func imageNewsButton(_ sender: Any) {
        
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
                newsImage.image = selectedImage
                
            }else{
                print("Image not found")
            }
            picker.dismiss(animated: true, completion: nil)
    }
    

    @IBAction func addNewsButton(_ sender: Any) {
        if(newsTitleTextField.text != ""){

                    let params: Parameters = [
                        "BrandsName": UserDefaults.standard.string(forKey: "_id")!,
                        "title": newsTitleTextField.text!
                    ]
            ApiCompanyService.addNewsToServer(image: newsImage.image!, parameters: params)
                    
                }
        self.dismiss(animated: true, completion: nil)
    }
}
