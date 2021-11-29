//
//  CategorieModelViewController.swift
//  showapp
//
//  Created by rami on 18/11/2021.
//

import UIKit
import CoreData
class CategorieModelViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    
    @IBOutlet weak var tableArticle: UITableView!
    
    var sousCategorieName:String?
    var tableauArticle = [Article]()
    

    @IBOutlet weak var scName: UILabel!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scName.text = sousCategorieName
        loadArticleToTableview(tableau:self.tableArticle)
       
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           tableArticle.reloadData()
       }
    
    
    func loadArticleToTableview (tableau:UITableView){
        articleService().getArticle { succes, reponse in
                if succes {
                    for article in reponse!.articles!{
                        self.tableauArticle.append(article)
                        DispatchQueue.main.async {
                            tableau.reloadWithAnimation()
                                    }
                    }
                }
                else{
                    print("pas d'article a afficher")
                }
            }
        }
        
        override func viewDidAppear(_ animated: Bool) {
            tableArticle.reloadWithAnimation()
        }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableauArticle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath)
                let contentView = cell.contentView
                let image = contentView.viewWithTag(1) as! UIImageView
                let label1 = contentView.viewWithTag(2) as! UILabel
                
        
        if scName.text == "pants" {
            image.imageFromServerURL(urlString: tableauArticle[indexPath.row].articlePicture!)
            label1.text = tableauArticle[indexPath.row].name
        }
                

                return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailModeSegue", sender: indexPath)
    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//        if segue.identifier == "detailModeSegue" && scName.text == "Shirt" {
//               let index = sender as! IndexPath
//               let destination = segue.destination as! DetailArticleViewController
//               destination.ArticleTitle = Shirts[index.row]
//               destination.ArticleImage = Shirts[index.row]
//           }
//        if segue.identifier == "detailModeSegue" && scName.text == "Pants & Jeans" {
//               let index = sender as! IndexPath
//               let destination = segue.destination as! DetailArticleViewController
//               destination.ArticleTitle = PantsJeans[index.row]
//               destination.ArticleImage = PantsJeans[index.row]
//           }
//
//    }
}

extension UITableView {

    func reloadWithAnimation() {
        self.reloadData()
        let tableViewHeight = self.bounds.size.height
        let cells = self.visibleCells
        var delayCounter = 0
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
        }
        for cell in cells {
            UIView.animate(withDuration: 1.6, delay: 0.08 * Double(delayCounter),usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            delayCounter += 1
        }
    }
}
