//
//  DetailArticleViewController.swift
//  showapp
//
//  Created by rami on 18/11/2021.
//

import UIKit
import Alamofire
class DetailArticleViewController: UIViewController {

    @IBAction func backButton(_ sender: Any) {
            self.dismiss(animated: true, completion: nil)
        }
    
    var ArticleTitle:String?
    var ArticleImage:String?
    var ArticlePrice:String?
    var idUser:String?
    var idArticle:String?
    var article :Article?
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var label: UILabel! //nom de l'article
    @IBOutlet weak var prix: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        image.imageFromServerURL(urlString: article!.articlePicture!)
        label.text = article!.name!
        prix.text = article!.price! + " TND"
        
    }
    
//    func insertItem(name: String, image: String) {
//
//
//        }
        
        
        
        
        func alertMessage(message: String) {
            
            let alert = UIAlertController(title: "Message", message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true)
        }
        
        
    var isActive:Bool = false
    @IBAction func addToFavourite(_ sender: UIButton) {
                if isActive {
                    isActive = false
                    guard let url = URL(string: "http://192.168.1.23:3000/favorites/"+article!._id+"/"+UserDefaults.standard.string(forKey: "_id")!) else {
                                fatalError("Error getting the url")
                            }

                    AF.request(url, method: .delete,parameters: nil)
                               .validate()
                               .responseJSON { response in
                                   switch response.result {
                                       case .success:
                                           print("Article deleted from favourit")
                                       case .failure(let error):
                                           print(error)
                                   }
                               }
        
    
        sender.setImage(UIImage(named: "whiteHeart"), for: .normal)
            } else {
                isActive = true
                sender.setImage(UIImage(named: "redHeart"), for: .normal)
                guard let url = URL(string: "http://192.168.1.23:3000/favorites/add") else {
                            fatalError("Error getting the url")
                        }

                        let params: Parameters = [
                                    "name": article!.name!,
                                    "price": article!.price!,
                                    "refArticle": article!._id,
                                    "refuser": UserDefaults.standard.string(forKey: "_id")!,
                                    "favPicture": article!.articlePicture!
                                ]

                AF.request(url, method: .post,parameters: params)
                           .validate()
                           .responseJSON { response in
                               switch response.result {
                                   case .success:
                                       print("Article added to favourit")
                                   case .failure(let error):
                                       print(error)
                               }
                           }
            }

}
    
    
    @IBOutlet weak var quantiteLabel: UILabel!
    @IBAction func stepper(_ sender: UIStepper) {
        quantiteLabel.text = String(sender.value)
    }
    
    @IBAction func addToCart(_ sender: Any) {
        
        guard let url = URL(string: "http://192.168.1.23:3000/factures/add") else {
                    fatalError("Error getting the url")
                }

                let params: Parameters = [
                            "name": article!.name!,
                            "price": article!.price!,
                            "refArticle": article!._id,
                            "refuser": UserDefaults.standard.string(forKey: "_id")!,
                            "cartPicture": article!.articlePicture!,
                            "qte": quantiteLabel.text!
                        ]

        AF.request(url, method: .post,parameters: params)
                   .validate()
                   .responseJSON { response in
                       switch response.result {
                           case .success:
                               print("Article added to cart")
                           case .failure(let error):
                               print(error)
                       }
                   }
    }
    
}
