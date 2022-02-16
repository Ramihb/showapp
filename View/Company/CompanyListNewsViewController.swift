//
//  CompanyListNewsViewController.swift
//  showapp
//
//  Created by rami on 13/12/2021.
//

import UIKit
import Alamofire
class CompanyListNewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBAction func backButton(_ sender: Any) {
                self.dismiss(animated: true, completion: nil)
            }
    var tableauNews = [New]()
    
    @IBAction func addNews(_ sender: Any) {
        performSegue(withIdentifier: "addNewsSegue", sender: "yes")

    }
    
    @IBOutlet weak var tableNews: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadNewsToTableview(tableau:self.tableNews)
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

                  //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
                  //tap.cancelsTouchesInView = false
                  view.addGestureRecognizer(tap)
            }
            
            @objc func dismissKeyboard() {
                //Causes the view (or one of its embedded text fields) to resign the first responder status.
                view.endEditing(true)
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
                                let image = contentView.viewWithTag(1) as! UIImageView
                let label = contentView.viewWithTag(2) as! UILabel

                            image.imageFromServerURL(urlString: tableauNews[indexPath.row].newsPicture!)
                label.text = tableauNews[indexPath.row].title

                        
                                

                                return cell
            }

 
    func viewWillAppear() {
               tableNews.reloadData()
                  }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                deleteNewsFromCompany(i: tableauNews[indexPath.row]._id)
                tableauNews.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }

    func deleteNewsFromCompany(i:String) {
        guard let url = URL(string: "https://backend-showapp.herokuapp.com/news/"+i) else {
                    fatalError("Error getting the url")
                }

        AF.request(url, method: .delete,parameters: nil)
                   .validate()
                   .responseJSON { response in
                       switch response.result {
                           case .success:
                               print("News deleted from company")
                           case .failure(let error):
                               print(error)
                       }
                   }
    }
}
