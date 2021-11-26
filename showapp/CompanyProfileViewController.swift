//
//  CompanyProfileViewController.swift
//  showapp
//
//  Created by rami on 8/11/2021.
//

import UIKit

class CompanyProfileViewController: UIViewController {
    
    var TransferImage: UIImage!

    @IBOutlet weak var imageCompany: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageCompany.image = TransferImage
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
