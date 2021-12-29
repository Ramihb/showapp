//
//  AdminUserListViewController.swift
//  showapp
//
//  Created by rami on 28/12/2021.
//

import UIKit
import Alamofire
import Foundation
class AdminUserListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBAction func LogOutAdmin(_ sender: Any) {
       
                UserDefaults.standard.removeObject(forKey: "_id")
                UserDefaults.standard.removeObject(forKey: "email")
                UserDefaults.standard.removeObject(forKey: "password")
                performSegue(withIdentifier: "logOutAdmin", sender: "yes")
    }
    var userName: String?
    var tableauUser = [User]()
    
    
    func viewWillAppear() {
        tableUser.reloadData()
               }
    
    
    @IBOutlet weak var tableUser: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        loadUsersToTableview(tableau: self.tableUser)
        //getUsers(tableau: self.tableUser)
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableauUser.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath)
                                let contentView = cell.contentView
                                let user = contentView.viewWithTag(1) as! UILabel

                            
        user.text = tableauUser[indexPath.row].firstName
                        
                                

                                return cell
    }

    
    
    func loadUsersToTableview (tableau:UITableView){
        ServiceUser().getAllUsers { succes, reponse in
                                    if succes {
                                        for user in reponse!.users!{
                                            self.tableauUser.append(user)
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
        updateUser(idUser: tableauUser[indexPath.row]._id)
    }
    func updateUser(idUser: String){
        guard let url = URL(string: "http://192.168.1.23:3000/users/"+idUser) else {
                    fatalError("Error getting the url")
                }
                let params: Parameters = [
                    "verified": "true"

                ]


                    AF.request(url, method: .put,parameters: params)
                        .validate()
                        .responseJSON { response in
                            switch response.result {
                                case .success (let json):

                                let response = json as! NSDictionary
                                if let faza = response["User"] as? [String: Any]{
                                    for(key, value) in faza{
                                        UserDefaults.standard.setValue(value, forKey: key)
                                        print("json: ",json)
                                        print("faza: ",faza)
                                    }

                                }

                                    print("Validation Successful")
                                self.prompt(title: "Success", message: "User is verified")
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
