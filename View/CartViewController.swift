//
//  CartViewController.swift
//  showapp
//
//  Created by rami on 7/11/2021.
//

import UIKit
import Alamofire
import Braintree
class CartViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var braintreeClient: BTAPIClient!
    
    @IBAction func backButton(_ sender: Any) {
                self.dismiss(animated: true, completion: nil)
            }
    var tableauCart = [Facture]()
    var gpsLocation = [Double]()
    var flous = 0
    
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
                        nameLabel.text = "Article: " +  tableauCart[indexPath.row].name!
                        priceLAbel.text = "Price: " + tableauCart[indexPath.row].price!
                        quantiterLAbel.text = "Quantite: " + tableauCart[indexPath.row].qte!
        flous = flous + (Int(tableauCart[indexPath.row].price!)! * Int(tableauCart[indexPath.row].qte!)!)
                         print("aaa",Int(tableauCart[indexPath.row].qte!)!)
        print("hedhi el total",flous)
        
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
        self.braintreeClient = BTAPIClient(authorization: "sandbox_gprq2vyh_ftywfwvxccrh9bvk")
        
        
    }

    
    func viewWillAppear() {
            tableCart.reloadData()
        }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let url = URL(string: "http://172.17.2.21:3000/factures/"+tableauCart[indexPath.row]._id+"/"+UserDefaults.standard.string(forKey: "_id")!) else {
                    fatalError("Error getting the url")
                }

        AF.request(url, method: .delete,parameters: nil)
                   .validate()
                   .responseJSON { response in
                       switch response.result {
                           case .success:
                               print("Article deleted from cart")
                           case .failure(let error):
                               print(error)
                       }
                   }
        if editingStyle == .delete {
            tableauCart.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            
        }
    }
    
   
    @IBAction func purchase(_ sender: Any) {
            performSegue(withIdentifier: "gpsSegue", sender: nil)
    }
    
    //testing paypal
    
    @IBAction func paypalBtn(_ sender: Any) {
        let payPalDriver = BTPayPalDriver(apiClient: self.braintreeClient)
            payPalDriver.viewControllerPresentingDelegate = self
            payPalDriver.appSwitchDelegate = self
        
        //specify the transaction amount:
        let request = BTPayPalRequest(amount: String(flous))
        request.currencyCode = "USD"
        
        payPalDriver.requestOneTimePayment(request) { (tokenizedPayPalAccount, error) in
            if let tokenizedPayPalAccount = tokenizedPayPalAccount {
                print("Got a nonce: \(tokenizedPayPalAccount.nonce)")
                
                //Access additional information
                let email = tokenizedPayPalAccount.email
                let firstName = tokenizedPayPalAccount.firstName
                let lastName = tokenizedPayPalAccount.lastName
                let phone = tokenizedPayPalAccount.phone
                
                //See BTPostalAdress.h for details
                let billingAddress = tokenizedPayPalAccount.billingAddress
                let shippingAddress = tokenizedPayPalAccount.shippingAddress
            } else if let error = error {
                    // Handle error
                } else {
                    // User canceled
                }
            }
    }
}

extension CartViewController : BTViewControllerPresentingDelegate {
    func paymentDriver(_ driver: Any, requestsPresentationOf viewController: UIViewController) {
        
    }
    
    func paymentDriver(_ driver: Any, requestsDismissalOf viewController: UIViewController) {
        
    }
    
    
    
    
}

extension CartViewController : BTAppSwitchDelegate {
    func appSwitcherWillPerformAppSwitch(_ appSwitcher: Any) {
        
    }
    
    func appSwitcher(_ appSwitcher: Any, didPerformSwitchTo target: BTAppSwitchTarget) {
        
    }
    
    func appSwitcherWillProcessPaymentInfo(_ appSwitcher: Any) {
        
    }
    
    
}
