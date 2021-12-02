//
//  DetailArticleViewController.swift
//  showapp
//
//  Created by rami on 18/11/2021.
//

import UIKit
import CoreData
class DetailArticleViewController: UIViewController {

    var ArticleTitle:String?
    var ArticleImage:String?
   
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var label: UILabel! //nom de l'article
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        image.image = UIImage(named: ArticleImage!)
        label.text = ArticleTitle!
        
    }
    
    func insertItem(name: String, image: String) {
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let persistentContainer = appDelegate.persistentContainer
            let managedContext = persistentContainer.viewContext
            
            
            let entityDescription = NSEntityDescription.entity(forEntityName: "Favourite", in: managedContext)
            let object = NSManagedObject.init(entity: entityDescription!, insertInto: managedContext)
            
            object.setValue(ArticleTitle!, forKey: "nameFavourite")
            object.setValue(ArticleImage!, forKey: "imageFavourite")
            
            do {
                
                try managedContext.save()
                alertMessage(message: "article is added to favourite")
                
            } catch {
                
                alertMessage(message:"article insert error !")
            }

        }
        
        
        
        
        func alertMessage(message: String) {
            
            let alert = UIAlertController(title: "Message", message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true)
        }
        
        
        func getByCreateria(name: String) -> Bool{
            
            var movieExist = false
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let persistentContainer = appDelegate.persistentContainer
            let managedContext = persistentContainer.viewContext
            
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Favourite")
            let predicate = NSPredicate(format: "nameFavourite = %@", name)
            request.predicate = predicate
            
            do {
                let result = try managedContext.fetch(request)
                if result.count > 0 {
                    
                    movieExist = true
                    // lezemni nredha ki nawed nenzel aal add to favourite tetnaha mel favouri
                    self.alertMessage(message: "Article allready added to favourite ")
                    
                }
                
            } catch {
                
                print("Fetching by criteria error !")
            }
            
            
            return movieExist
        }
    @IBAction func addToFavourite(_ sender: Any) {
        if !getByCreateria(name: ArticleTitle!) {
                   
                   insertItem(name: ArticleTitle!, image: ArticleImage!)
               }
    }
   

}
