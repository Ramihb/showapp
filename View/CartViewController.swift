//
//  CartViewController.swift
//  showapp
//
//  Created by rami on 7/11/2021.
//

import UIKit

class CartViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBAction func backButton(_ sender: Any) {
                self.dismiss(animated: true, completion: nil)
            }
    var tableauCart = [Facture]()
    @IBOutlet weak var tableCart: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableauCart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath)
                        
                        let contentView = cell.contentView
                        
                        //widgets
                        let imageView = contentView.viewWithTag(1) as! UIImageView
                        let nameLabel = contentView.viewWithTag(2) as! UILabel
                        let priceLAbel = contentView.viewWithTag(3) as! UILabel
                        let quantiterLAbel = contentView.viewWithTag(4) as! UILabel
        
                        imageView.imageFromServerURL(urlString: tableauCart[indexPath.row].cartPicture!)
                        nameLabel.text = tableauCart[indexPath.row].name!
                        priceLAbel.text = tableauCart[indexPath.row].price!
                        quantiterLAbel.text = tableauCart[indexPath.row].qte!
                        return cell
    }
    
    
    
    func loadArticleToTableCart (tableau:UITableView){
            articleService().getUserCarts { succes, reponse in
                                if succes {
                                    for cart in reponse!.factures!{
                                        self.tableauCart.append(cart)
                                        DispatchQueue.main.async {
                                            tableau.reloadData()
                                                    }
                                    }
                                }
                                else{
                                    print("pas de cart a afficher")
                                }
                            }
                        }
    
    
    
    
    
    
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        loadArticleToTableCart(tableau: self.tableCart)
    }
    func viewWillAppear() {
            tableCart.reloadData()
        }

   

}
