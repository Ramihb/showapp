//
//  SearchViewController.swift
//  showapp
//
//  Created by rami on 7/11/2021.
//

import UIKit


class SearchViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    
    //var dataa = ["Home", "Mode", "Hi-tech", "Make up", "Jewellery", "Art deco", "Shoes"]

//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return data.count //return de 4 elements
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "CategorieSearch")
//            let contentView = cell?.contentView
//
//            let label = contentView?.viewWithTag(1) as! UILabel
//            let imageView = contentView?.viewWithTag(2) as! UIImageView
//
//            label.text = data[indexPath.row]
//            imageView.image = UIImage(named: data[indexPath.row])
//
//        return cell!
//
//    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewData = [cellData(opened: false, data: "Home", insidedata: []),
                         cellData(opened: false, data: "Mode", insidedata: ["Shirts", "T-Shirt", "Pants & Jeans", "Underware", "Jackets", "Coats", "Sweaters"]),
                         cellData(opened: false, data: "Hi-tech", insidedata: ["haja1", "haja2", "haja3", "haja4"]),
                         cellData(opened: false, data: "Make up", insidedata: ["haja1", "haja2", "haja3", "haja4"]),
                         cellData(opened: false, data: "Jewellery", insidedata: ["haja1", "haja2", "haja3", "haja4"]),
                         cellData(opened: false, data: "Art deco", insidedata: ["haja1", "haja2", "haja3", "haja4"]),
                         cellData(opened: false, data: "Shoes", insidedata: ["haja1", "haja2", "haja3", "haja4"])
        ]
      

    
    }
    
    //trying expanding table view cells
    
    
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
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if tableViewData[indexPath.section].opened == true {
//            tableViewData[indexPath.section].opened = false
//                let sections = IndexSet.init(integer: indexPath.section)
//                tableView.reloadSections(sections, with: .none)
//            print("hedhi eli tsakar")
//        } else {
//            tableViewData[indexPath.section].opened = true
//                let sections = IndexSet.init(integer: indexPath.section)
//                tableView.reloadSections(sections, with: .none)
//            print("hedhi eli thell")
//        }
//
//        if tableViewData[indexPath.section].data == "Home" {
//            performSegue(withIdentifier: "segueSearchToHome", sender: indexPath)
//        } else if tableViewData[indexPath.section].insidedata == ["T-Shirt"] {
//                performSegue(withIdentifier: "segueSearchToModeTshirt", sender: indexPath)
//        }
//    }

    
    
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
        performSegue(withIdentifier: "segueSearchToModeShirt", sender: indexPath)
        }
        if tableViewData[indexPath.section].data == "Mode" && indexPath.row == 2 {
        performSegue(withIdentifier: "segueSearchToModeTshirt", sender: indexPath)
        }
        if tableViewData[indexPath.section].data == "Mode" && indexPath.row == 3 {
        performSegue(withIdentifier: "segueSearchToModePants&Jeans", sender: indexPath)
        }
        if tableViewData[indexPath.section].data == "Mode" && indexPath.row == 4 {
        performSegue(withIdentifier: "segueSearchToModeUnderware", sender: indexPath)
        }
        if tableViewData[indexPath.section].data == "Mode" && indexPath.row == 5 {
        performSegue(withIdentifier: "segueSearchToModeJackets", sender: indexPath)
        }
        if tableViewData[indexPath.section].data == "Mode" && indexPath.row == 6 {
        performSegue(withIdentifier: "segueSearchToModeCoats", sender: indexPath)
        }
        if tableViewData[indexPath.section].data == "Mode" && indexPath.row == 7 {
        performSegue(withIdentifier: "segueSearchToModeSweaters", sender: indexPath)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueSearchToModeShirt" {
            
            let destination = segue.destination as! CategorieModelViewController
            destination.sousCategorieName = "Shirt"
        } else if segue.identifier == "segueSearchToModeTshirt" {
            
            let destination = segue.destination as! CategorieModelViewController
            destination.sousCategorieName = "T-Shirt"
        }else if segue.identifier == "segueSearchToModePants&Jeans" {
            
            let destination = segue.destination as! CategorieModelViewController
            destination.sousCategorieName = "Pants & Jeans"
        }else if segue.identifier == "segueSearchToModeUnderware" {
            
            let destination = segue.destination as! CategorieModelViewController
            destination.sousCategorieName = "Underware"
        }else if segue.identifier == "segueSearchToModeJackets" {
            
            let destination = segue.destination as! CategorieModelViewController
            destination.sousCategorieName = "Jackets"
        }else if segue.identifier == "segueSearchToModeCoats" {
            
            let destination = segue.destination as! CategorieModelViewController
            destination.sousCategorieName = "Coats"
        }else if segue.identifier == "segueSearchToModeSweaters" {
            
            let destination = segue.destination as! CategorieModelViewController
            destination.sousCategorieName = "Sweaters"
        }
        
    }
}

