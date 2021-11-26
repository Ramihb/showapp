//
//  CategorieModelViewController.swift
//  showapp
//
//  Created by rami on 18/11/2021.
//

import UIKit
import CoreData
class CategorieModelViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    

    var sousCategorieName:String?
    var Shirts = ["Shirt1", "Shirt2", "Shirt3"]
    var PantsJeans = ["Pants1", "Pants2", "Jeans1", "Jeans2"]
    var x = 0

    @IBOutlet weak var scName: UILabel!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scName.text = sousCategorieName
        
       
        
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if scName.text == "Shirt" {
           x = Shirts.count
        }
        if scName.text == "Pants & Jeans" {
           x = PantsJeans.count
        }
        return x
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell");
                let contentView = cell?.contentView
                let image = contentView?.viewWithTag(1) as! UIImageView
                let label1 = contentView?.viewWithTag(2) as! UILabel
                
        if scName.text == "Shirt" {
            image.image = UIImage(named: Shirts[indexPath.row])
            label1.text = Shirts[indexPath.row]
        }
        if scName.text == "Pants & Jeans" {
            image.image = UIImage(named: PantsJeans[indexPath.row])
            label1.text = PantsJeans[indexPath.row]
        }
                

                return cell!
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailModeSegue", sender: indexPath)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           
        if segue.identifier == "detailModeSegue" && scName.text == "Shirt" {
               let index = sender as! IndexPath
               let destination = segue.destination as! DetailArticleViewController
               destination.ArticleTitle = Shirts[index.row]
               destination.ArticleImage = Shirts[index.row]
           }
        if segue.identifier == "detailModeSegue" && scName.text == "Pants & Jeans" {
               let index = sender as! IndexPath
               let destination = segue.destination as! DetailArticleViewController
               destination.ArticleTitle = PantsJeans[index.row]
               destination.ArticleImage = PantsJeans[index.row]
           }
    
    }
}


