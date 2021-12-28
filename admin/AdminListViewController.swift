//
//  AdminListViewController.swift
//  showapp
//
//  Created by rami on 28/12/2021.
//
import Alamofire
import UIKit

class AdminListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var companyName: String?
    var tableauCompany = [Company]()
    
    /*@IBAction func back(_ sender: Any) {
            self.dismiss(animated: true)
        }*/
    func viewWillAppear() {
        tableCompany.reloadData()
               }
    
    
    @IBOutlet weak var tableCompany: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        loadCompanysToTableview(tableau: self.tableCompany)
        
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableauCompany.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompanyCell", for: indexPath)
                                let contentView = cell.contentView
                                let company = contentView.viewWithTag(1) as! UILabel

                            
        company.text = tableauCompany[indexPath.row].businessNameCompany
                        
                                

                                return cell
    }

    
    
    func loadCompanysToTableview (tableau:UITableView){
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
                
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        updateCompany(idCompany: tableauCompany[indexPath.row]._id!)
    }
    func updateCompany(idCompany: String){
        guard let url = URL(string: "http://192.168.1.14:3000/company/"+idCompany) else {
                    fatalError("Error getting the url")
                }
                let params: Parameters = [
                    "verifiedCompany": "true"

                ]


                    AF.request(url, method: .put,parameters: params)
                        .validate()
                        .responseJSON { response in
                            switch response.result {
                                case .success (let json):

                                let response = json as! NSDictionary
                                if let faza = response["Company"] as? [String: Any]{
                                    for(key, value) in faza{
                                        UserDefaults.standard.setValue(value, forKey: key)
                                        print("json: ",json)
                                        print("faza: ",faza)
                                    }

                                }
                                /*let token = response["token"]
                                
                                UserDefaults.standard.setValue(response["token"]!, forKey: "token")*/
        //                        UserDefaults.standard.setValue(response["userId"]!, forKey: "userId")
                                    print("Validation Successful")
                                self.prompt(title: "Success", message: "Company is verified")
//                                self.performSegue(withIdentifier: "companyStoryBoardSegue", sender: "yes")
                                case .failure(let error):
                                self.prompt(title: "Echec", message: "Email ou mot de passe incorrect")
                                if let data = response.data {
                                    let json = String(data: data, encoding: String.Encoding.utf8)
                                    print("Failure Response: \(json)")
                                }
                                
                                
                            }
                        }
    }
    func prompt(title:String, message:String){
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .destructive , handler: nil)
                alert.addAction(action)
                present(alert, animated: true, completion: nil)
            }
}
