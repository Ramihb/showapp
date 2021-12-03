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
    

    

}
