//
//  SearchViewController.swift
//  showapp
//
//  Created by rami on 7/11/2021.
//

import UIKit


class SearchViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {

    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewData = [cellData(opened: false, data: "Home", insidedata: []),
                         cellData(opened: false, data: "Mode", insidedata: ["Sweaters", "Outlet", "Pants", "Shoes", "Jackets", "Dress"]),
                         cellData(opened: false, data: "Hi-tech", insidedata: ["haja1", "haja2", "haja3", "haja4"]),
                         cellData(opened: false, data: "Make up", insidedata: ["haja1", "haja2", "haja3", "haja4"]),
                         cellData(opened: false, data: "Jewellery", insidedata: ["haja1", "haja2", "haja3", "haja4"]),
                         cellData(opened: false, data: "Art deco", insidedata: ["haja1", "haja2", "haja3", "haja4"]),
                         cellData(opened: false, data: "Shoes", insidedata: ["haja1", "haja2", "haja3", "haja4"])
        ]
      

    
    }
    
    
    struct cellData {
        var opened = Bool()
        var data = String()
        var insidedata = [String]()

    }
    
    var tableViewData = [cellData]()
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewData.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableViewData[section].opened == true {
            return tableViewData[section].insidedata.count + 1
        }else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CategorieSearch")
                    
        else {
                return UITableViewCell()
            }
            let contentView = cell.contentView
            
            let label = contentView.viewWithTag(1) as! UILabel
                        let imageView = contentView.viewWithTag(2) as! UIImageView
            
            label.text = tableViewData[indexPath.section].data
            imageView.image = UIImage(named: tableViewData[indexPath.section].data)
            
                    return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
                return UITableViewCell()
            }
        cell.textLabel?.text = tableViewData[indexPath.section].insidedata[indexPath.row - 1]
            
            return cell
        }
    }


    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0 {
            tableViewData[indexPath.section].opened = !tableViewData[indexPath.section].opened
            tableView.reloadSections([indexPath.section], with: .none)
        } else {
            print("tapped inside data")
            
                
                
            }
            
        
        if tableViewData[indexPath.section].data == "Home" {
        performSegue(withIdentifier: "segueSearchToHome", sender: indexPath)
        }
        if tableViewData[indexPath.section].data == "Mode" && indexPath.row == 1 {
        performSegue(withIdentifier: "segueSearchToModeSweaters", sender: indexPath)
        }
        if tableViewData[indexPath.section].data == "Mode" && indexPath.row == 2 {
        performSegue(withIdentifier: "segueSearchToModeOutlet", sender: indexPath)
        }
        if tableViewData[indexPath.section].data == "Mode" && indexPath.row == 3 {
        performSegue(withIdentifier: "segueSearchToModePants", sender: indexPath)
        }
        if tableViewData[indexPath.section].data == "Mode" && indexPath.row == 4 {
        performSegue(withIdentifier: "segueSearchToModeShoes", sender: indexPath)
        }
        if tableViewData[indexPath.section].data == "Mode" && indexPath.row == 5 {
        performSegue(withIdentifier: "segueSearchToModeJackets", sender: indexPath)
        }
        if tableViewData[indexPath.section].data == "Mode" && indexPath.row == 6 {
        performSegue(withIdentifier: "segueSearchToModeDress", sender: indexPath)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueSearchToModeSweaters" {
            
            let destination = segue.destination as! CategoryClothesViewController
            destination.sousCategorieName = "sweaters"
        } else if segue.identifier == "segueSearchToModeOutlet" {
            
            let destination = segue.destination as! CategoryClothesViewController
            destination.sousCategorieName = "outlet"
        }else if segue.identifier == "segueSearchToModePants" {
            
            let destination = segue.destination as! CategoryClothesViewController
            destination.sousCategorieName = "pants"
        }else if segue.identifier == "segueSearchToModeShoes" {
            
            let destination = segue.destination as! CategoryClothesViewController
            destination.sousCategorieName = "shoes"
        }else if segue.identifier == "segueSearchToModeJackets" {
            
            let destination = segue.destination as! CategoryClothesViewController
            destination.sousCategorieName = "jacket"
        }else if segue.identifier == "segueSearchToModeDress" {
            
            let destination = segue.destination as! CategoryClothesViewController
            destination.sousCategorieName = "Dress"
        }
        
    }
}

