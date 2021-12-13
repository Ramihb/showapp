//
//  QrCodeViewController.swift
//  showapp
//
//  Created by rami on 13/12/2021.
//

import UIKit

class QrCodeViewController: UIViewController {

    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @IBOutlet weak var qrImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let name = "Hello from showapp"
        qrImageView.image = generateQrCode(Name: name)

        
    }
    
    func generateQrCode(Name:String) -> UIImage? {
        let name_data = Name.data(using: String.Encoding.ascii)
        if let filter = CIFilter(name: "CIQRCodeGenerator"){
            filter.setValue(name_data, forKey: "inputMessage")
            
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            if let output = filter.outputImage?.transformed(by: transform){
                return UIImage(ciImage: output)
            }
        }
        return nil
    }

    
}
