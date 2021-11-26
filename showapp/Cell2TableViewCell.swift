//
//  Cell2TableViewCell.swift
//  showapp
//
//  Created by rami on 13/11/2021.
//

import UIKit

class Cell2TableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var myResult:[detail]! = [detail]()
    
    func AssaignData(){
        var A1:detail! = detail()
        
        A1.title = "Home"
        A1.categorie = nil
        self.myResult.append(A1)
        
        A1.title = "Mode"
        A1.categorie = "T-Shirt"
        self.myResult.append(A1)
        
        A1.title = "Hi-Tech"
        A1.categorie = "hiitech"
        self.myResult.append(A1)
        
        A1.title = "Beauty"
        A1.categorie = "maquillage"
        self.myResult.append(A1)
    }
    
    

    struct detail {
        var categorie:String?
        var title:String?
        var expand:Bool? = false
    }
    
}
