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
        
        
        

    
   
        
        
            }
