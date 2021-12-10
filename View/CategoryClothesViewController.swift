//
//  CategoryClothesViewController.swift
//  showapp
//
//  Created by rami on 6/12/2021.
//

import UIKit
import Alamofire
class CategoryClothesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
        var sousCategorieName:String?
        var tableauArticle = [Article]()
    @IBOutlet weak var scName: UILabel!
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
    

    override func viewDidLoad() {
        super.viewDidLoad()

        scName.text = sousCategorieName
        loadArticleToTableview(collection:self.collectionArticle)
        
    }
    
    func loadArticleToTableview (collection:UICollectionView){
        articleService().getArticleByType(ArticleType: scName.text!) { succes, reponse in
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
    
    //test red button
    
    
    var isActive:Bool = false
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(tableauArticle[indexPath.row].name!)
        print(tableauArticle[indexPath.row].price!)
        print(tableauArticle[indexPath.row]._id)
        print(tableauArticle[indexPath.row].articlePicture!)
        print(UserDefaults.standard.string(forKey: "_id")!)
        
        performSegue(withIdentifier: "detailArticle", sender: indexPath)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailArticle" {
                    let index = sender as! IndexPath
                    let destination = segue.destination as! DetailArticleViewController
//                    destination.ArticleTitle = tableauArticle[index.row].name!
//                    destination.ArticleImage = tableauArticle[index.row].articlePicture!
//                    destination.ArticlePrice = tableauArticle[index.row].price!
//                    destination.idArticle = tableauArticle[index.row]._id
                    destination.idUser = UserDefaults.standard.string(forKey: "_id")!
                    destination.article = tableauArticle[index.row]
                }
    }
    

        
        
    @IBAction func addToCart(_ sender: Any) {
        
        
        
    }
    
    
        }
    
    
    
    

