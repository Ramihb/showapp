//
//  BrandsViewController.swift
//  showapp
//
//  Created by rami on 15/11/2021.
//

import UIKit

class BrandsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tableauCompany = [Company]()

        override func viewDidLoad() {
            super.viewDidLoad()

            loadNewsToTableview(tableau:self.tableBrands)
        }
        
        func loadNewsToTableview (tableau:UITableView){
            ApiCompanyService().getAllBrands { succes, reponse in
                            if succes {
                                for company in reponse!.companys!{
                                    self.tableauCompany.append(company)
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
                return tableauCompany.count
            }

            func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let cell = tableView.dequeueReusableCell(withIdentifier: "BrandsCell", for: indexPath)
                                let contentView = cell.contentView
                                let image = contentView.viewWithTag(1) as! UIImageView

                            image.imageFromServerURL(urlString: tableauCompany[indexPath.row].brandPicCompany!)


                        
                                

                                return cell
            }
        
        @IBOutlet weak var tableBrands: UITableView!
           func viewWillAppear() {
               tableBrands.reloadData()
                  }

}
