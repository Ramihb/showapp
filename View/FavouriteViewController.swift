//
//  FavouriteViewController.swift
//  showapp
//
//  Created by rami on 15/11/2021.
//

import UIKit
import Alamofire
class FavouriteViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tableauFav = [Favorite]()
    var articleName:String?
    var articlePrice:String?
    var articleImage:String?
    var articleID:String?
    
    @IBOutlet weak var tableFav: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableauFav.count
    }
    
    
    func loadArticleToTableFav (tableau:UITableView){
        articleService().getUserFavourites { succes, reponse in
                            if succes {
                                for fav in reponse!.favorites!{
                                    self.tableauFav.append(fav)
                                    DispatchQueue.main.async {
                                        tableau.reloadData()
                                                }
                                }
                            }
                            else{
                                print("pas de favourit a afficher")
                            }
                        }
                    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavouriteCell", for: indexPath)
                
                let contentView = cell.contentView
                
                //widgets
                let imageView = contentView.viewWithTag(1) as! UIImageView
                let nameLabel = contentView.viewWithTag(2) as! UILabel
                //let priceLAbel = contentView.viewWithTag(3) as! UILabel
                //widgets setting value
        imageView.imageFromServerURL(urlString: tableauFav[indexPath.row].favPicture!)
        nameLabel.text = tableauFav[indexPath.row].name!
        articleName = tableauFav[indexPath.row].name!
        articlePrice = tableauFav[indexPath.row].price!
        articleID = tableauFav[indexPath.row]._id
        articleImage = tableauFav[indexPath.row].favPicture!
                
                return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loadArticleToTableFav(tableau: self.tableFav)
        // Do any additional setup after loading the view.
    }
    
    func viewWillAppear() {
        tableFav.reloadData()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let url = URL(string: "http://172.17.2.21:3000/favorites/"+tableauFav[indexPath.row]._id+"/"+UserDefaults.standard.string(forKey: "_id")!) else {
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
        if editingStyle == .delete {
            tableauFav.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            
        }
    }

    
    
    
    @IBAction func addToCartBTN(_ sender: Any) {
        guard let url = URL(string: "http://172.17.2.21:3000/factures/add") else {
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
