//
//  BrandDetailsViewController.swift
//  showapp
//
//  Created by rami on 15/11/2021.
//

import UIKit
import Alamofire

class BrandDetailsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    

    
 
    @IBOutlet weak var scName: UILabel!
    var sousCategorieName:String?
            var tableauArticle = [Article]()
    var article :Article?
    var articleName:String?
    var articlePrice:String?
    var articleImage:String?
    var articleID:String?
        @IBOutlet weak var collectionArticle: UICollectionView!
        
        
        @IBAction func back(_ sender: Any) {
                self.dismiss(animated: true)
            }
        
        
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return tableauArticle.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArticleCell", for: indexPath)
                            let contentView = cell.contentView
                            let image = contentView.viewWithTag(1) as! UIImageView
                            let labelName = contentView.viewWithTag(2) as! UILabel
                            let labelPrice = contentView.viewWithTag(3) as! UILabel
                    
                    
                        image.imageFromServerURL(urlString: tableauArticle[indexPath.row].articlePicture!)
                        labelName.text = tableauArticle[indexPath.row].name
                        labelPrice.text = tableauArticle[indexPath.row].price
                            articleName = tableauArticle[indexPath.row].name!
                            articlePrice = tableauArticle[indexPath.row].price!
                            articleID = tableauArticle[indexPath.row]._id
            articleImage = tableauArticle[indexPath.row].articlePicture!

                            return cell
        }
        
        var idbrand:String?
    
        override func viewDidLoad() {
            super.viewDidLoad()
            scName.text = sousCategorieName
            loadArticleToTableview(collection:self.collectionArticle)
            
        }
    
    func loadArticleToTableview (collection:UICollectionView){
        
            articleService().getBrandArticle(BrandId: scName.text!) { succes, reponse in
                        if succes {
                            for article in reponse!.articles!{
                                self.tableauArticle.append(article)
                                DispatchQueue.main.async {
                                    collection.reloadData()
                                            }
                            }
                        }
                        else{
                            print("pas d'article a afficher")
                        }
                    }
                }
        
                func viewDidAppear() {
                    collectionArticle.reloadData()
                }
        
        
        
    @IBAction func addToCartBtn(_ sender: Any) {
        guard let url = URL(string: "http://192.168.1.12:3000/factures/add") else {
                    fatalError("Error getting the url")
                }

                let params: Parameters = [
                            "name": articleName!,
                            "price": articlePrice!,
                            "refArticle": articleID!,
                            "refuser": UserDefaults.standard.string(forKey: "_id")!,
                            "cartPicture": articleImage!,
                            "qte": "1"
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
        let alert = UIAlertController(title: "Message", message: "article has been added to cart", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
    
    
   
        
        
            }
