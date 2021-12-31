//
//  AdminListViewController.swift
//  showapp
//
//  Created by rami on 28/12/2021.
//
import Alamofire
import UIKit

class AdminListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBAction func LogOutAdmin(_ sender: Any) {
       
                UserDefaults.standard.removeObject(forKey: "_id")
                UserDefaults.standard.removeObject(forKey: "email")
                UserDefaults.standard.removeObject(forKey: "password")
                performSegue(withIdentifier: "logOutAdmin", sender: "yes")
    }
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
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompanyCell", for: indexPath)
                                let contentView = cell.contentView
                                let company = contentView.viewWithTag(1) as! UILabel

                            
        company.text = tableauCompany[indexPath.row].businessNameCompany
        if tableauCompany[indexPath.row].verifiedCompany == true {
            cell.backgroundColor = hexStringToUIColor(hex: "#69f542")
        } else {
            cell.backgroundColor = hexStringToUIColor(hex: "#b83916")
        }
                                

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
                
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        updateCompany(idCompany: tableauCompany[indexPath.row]._id!)
//    }
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
//                                self.prompt(title: "Success", message: "Company is verified")
//                                self.performSegue(withIdentifier: "companyStoryBoardSegue", sender: "yes")
                                case .failure(let error):
//                                self.prompt(title: "Echec", message: "Email ou mot de passe incorrect")
                                if let data = response.data {
                                    let json = String(data: data, encoding: String.Encoding.utf8)
                                    print("Failure Response: \(json)")
                                }
                                
                                
                            }
                        }
    }
    
    
    func updateCompanyFalse(idCompany: String){
        guard let url = URL(string: "http://192.168.1.14:3000/company/"+idCompany) else {
                    fatalError("Error getting the url")
                }
                let params: Parameters = [
                    "verifiedCompany": "false"

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
//                                self.prompt(title: "Success", message: "Company is verified")
//                                self.performSegue(withIdentifier: "companyStoryBoardSegue", sender: "yes")
                                case .failure(let error):
//                                self.prompt(title: "Echec", message: "Email ou mot de passe incorrect")
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
    
    
    
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let company = tableauCompany[indexPath.row]
        let verifiedActionTitle = company.verifiedCompany ? "Unverified" : "Verified"
        
        let verifiedAction = UITableViewRowAction(style: .normal, title: verifiedActionTitle) { _, indexPath in
            self.tableauCompany[indexPath.row].verifiedCompany.toggle()
            self.tableCompany.reloadRows(at: [indexPath], with: .automatic)
            if self.tableauCompany[indexPath.row].verifiedCompany == true {
                self.updateCompany(idCompany: self.tableauCompany[indexPath.row]._id!)
            } else {
                self.updateCompanyFalse(idCompany: self.tableauCompany[indexPath.row]._id!)
            }
        }
        if tableauCompany[indexPath.row].verifiedCompany == true {
            verifiedAction.backgroundColor = .systemRed
        } else {
            verifiedAction.backgroundColor = .systemGreen
        }
        
        return [verifiedAction]
    }
}
