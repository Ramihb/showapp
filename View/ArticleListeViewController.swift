//
//  ArticleListeViewController.swift
//  showapp
//
//  Created by rami on 15/11/2021.
//

import UIKit

class ArticleListeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    var articleName: String?
    var articleImage: String?
    var tableauArticle = [Article]()
    
    @IBOutlet weak var tableArticle: UITableView!
    func viewWillAppear() {
               tableArticle.reloadData()
           }
        
    func loadArticleToTableview (tableau:UITableView){
            articleService().getCompanyArticle { succes, reponse in
                    if succes {
                        for article in reponse!.articles!{
                            self.tableauArticle.append(article)
                            DispatchQueue.main.async {
                                tableau.reloadData()
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
                        let labelName = contentView.viewWithTag(2) as! UILabel

                    image.imageFromServerURL(urlString: tableauArticle[indexPath.row].articlePicture!)
                    labelName.text = tableauArticle[indexPath.row].name

                
                        

                        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        loadArticleToTableview(tableau:self.tableArticle)
    }
    
    
    @IBAction func buttonAddArticle(_ sender: Any) {
        performSegue(withIdentifier: "articleListToAddArticleSegue", sender: "yes")
    }
    
    
    
}
