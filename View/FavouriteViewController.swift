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
        if editingStyle == .delete {
            tableauFav.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            guard let url = URL(string: "http://192.168.1.23:3000/favorites/"+tableauFav[indexPath.row]._id+"/"+UserDefaults.standard.string(forKey: "_id")!) else {
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
        }
    }

}
