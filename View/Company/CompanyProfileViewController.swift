//
//  CompanyProfileViewController.swift
//  showapp
//
//  Created by rami on 15/11/2021.
//

import UIKit

class CompanyProfileViewController: UIViewController {

    @IBOutlet weak var profileCompanyImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileCompanyImage.imageFromServerURL(urlString: UserDefaults.standard.string(forKey: "brandPicCompany")!)
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func News(_ sender: Any) {
        performSegue(withIdentifier: "listNewsSegue", sender: "yes")
    }
    
    
    @IBAction func LogOut(_ sender: Any) {

        UserDefaults.standard.removeObject(forKey: "_id")
        UserDefaults.standard.removeObject(forKey: "emailCompany")
        UserDefaults.standard.removeObject(forKey: "passwordCompany")
        UserDefaults.standard.removeObject(forKey: "phoneNumberCompany")
        UserDefaults.standard.removeObject(forKey: "lastNameCompany")
        UserDefaults.standard.removeObject(forKey: "firstNameCompany")
        UserDefaults.standard.removeObject(forKey: "categoryCompany")
        UserDefaults.standard.removeObject(forKey: "brandPicCompany")
        UserDefaults.standard.removeObject(forKey: "businessNameCompany")
        UserDefaults.standard.removeObject(forKey: "verifiedCompany")
        UserDefaults.standard.removeObject(forKey: "__v")
        performSegue(withIdentifier: "logOutCompanySegue", sender: "yes")
    }
    
}
