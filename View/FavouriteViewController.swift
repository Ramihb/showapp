//
//  FavouriteViewController.swift
//  showapp
//
//  Created by rami on 15/11/2021.
//

import UIKit
import CoreData

class FavouriteViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var articleName = [String]()
    var articleImage = [String]()
    var articlePrice = [String]()
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavouriteCell", for: indexPath)
                
                let contentView = cell.contentView
                
                //widgets
                let imageView = contentView.viewWithTag(1) as! UIImageView
                let nameLabel = contentView.viewWithTag(2) as! UILabel
                
                //widgets setting value
                imageView.image = UIImage(named: articleImage[indexPath.row])
                nameLabel.text = articleName[indexPath.row]
                
                return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        retreiveData()
        // Do any additional setup after loading the view.
    }
    
    func retreiveData() {
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let persistentContainer = appDelegate.persistentContainer
            let managedContext = persistentContainer.viewContext
            
            
            let request = NSFetchRequest<NSManagedObject>(entityName: "Favourite")
            
            do {
                
                let data = try managedContext.fetch(request)
                for item in data {
                    
                    articleName.append(item.value(forKey: "nameFavourite") as! String)
                    articleImage.append(item.value(forKey: "imageFavourite") as! String)
                    articlePrice.append(item.value(forKey: "priceFavourite") as! String)
                    
                }
                
            } catch  {
                
                print("Fetching error !")
            }
            
        }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            articleName.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            tableView.endUpdates()
        }
    }

    

}
