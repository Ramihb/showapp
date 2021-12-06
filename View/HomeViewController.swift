//
//  HomeViewController.swift
//  showapp
//
//  Created by rami on 15/11/2021.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
        var tableauNews = [New]()

    override func viewDidLoad() {
        super.viewDidLoad()

        loadNewsToTableview(tableau:self.tableNews)
    }
    
    func loadNewsToTableview (tableau:UITableView){
        ApiCompanyService().getCompanyNews { succes, reponse in
                        if succes {
                            for new in reponse!.news!{
                                self.tableauNews.append(new)
                                DispatchQueue.main.async {
                                    tableau.reloadData()
                                            }
                            }
                        }
                        else{
                            print("pas de news a afficher")
                        }
                    }
                }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return tableauNews.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath)
                            let contentView = cell.contentView
                            let image = contentView.viewWithTag(5) as! UIImageView

                        image.imageFromServerURL(urlString: tableauNews[indexPath.row].newsPicture!)


                    
                            

                            return cell
        }
    
    @IBOutlet weak var tableNews: UITableView!
       func viewWillAppear() {
           tableNews.reloadData()
              }

}
