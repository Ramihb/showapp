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
                         cellData(opened: false, data: "Mode", insidedata: ["Sweaters", "Outlet", "Pants", "Shoes", "Jackets", "Dress", "Other"]),
                         cellData(opened: false, data: "High tech", insidedata: ["Pc", "Tv", "Computers' accessories", "Other"]),
                         cellData(opened: false, data: "Beauty", insidedata: ["make-up", "Art Supplies", "Other"]),
                         cellData(opened: false, data: "Baby", insidedata: []),
                         cellData(opened: false, data: "Jewellery", insidedata: ["earrings", "rings", "bracelets"]),
                         cellData(opened: false, data: "Art deco", insidedata: ["art deco", "Other"])
                         
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
            
        //Home
        if tableViewData[indexPath.section].data == "Home" {
        performSegue(withIdentifier: "segueSearchToHome", sender: indexPath)
        }
        //Mode
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
        if tableViewData[indexPath.section].data == "Mode" && indexPath.row == 7 {
        performSegue(withIdentifier: "segueSearchToModeOther", sender: indexPath)
        }
        //High tech
        if tableViewData[indexPath.section].data == "High tech" && indexPath.row == 1 {
        performSegue(withIdentifier: "segueSearchToPc", sender: indexPath)
        }
        if tableViewData[indexPath.section].data == "High tech" && indexPath.row == 2 {
        performSegue(withIdentifier: "segueSearchToTv", sender: indexPath)
        }
        if tableViewData[indexPath.section].data == "High tech" && indexPath.row == 3 {
        performSegue(withIdentifier: "segueSearchToComputersAccessories", sender: indexPath)
        }
        if tableViewData[indexPath.section].data == "High tech" && indexPath.row == 4 {
        performSegue(withIdentifier: "segueSearchToHighTechOther", sender: indexPath)
        }
        //Beauty
        if tableViewData[indexPath.section].data == "Beauty" && indexPath.row == 1 {
        performSegue(withIdentifier: "segueSearchToMakeUp", sender: indexPath)
        }
        if tableViewData[indexPath.section].data == "Beauty" && indexPath.row == 2 {
        performSegue(withIdentifier: "segueSearchToArtSupplies", sender: indexPath)
        }
        if tableViewData[indexPath.section].data == "Beauty" && indexPath.row == 3 {
        performSegue(withIdentifier: "segueSearchToBeautyOther", sender: indexPath)
        }
        //Baby
        if tableViewData[indexPath.section].data == "Baby" {
        performSegue(withIdentifier: "segueSearchToBaby", sender: indexPath)
        }
        //Jewellery
        if tableViewData[indexPath.section].data == "Jewellery" && indexPath.row == 1 {
        performSegue(withIdentifier: "segueSearchToEarrings", sender: indexPath)
        }
        if tableViewData[indexPath.section].data == "Jewellery" && indexPath.row == 2 {
        performSegue(withIdentifier: "segueSearchToRings", sender: indexPath)
        }
        if tableViewData[indexPath.section].data == "Jewellery" && indexPath.row == 3 {
        performSegue(withIdentifier: "segueSearchToBracelets", sender: indexPath)
        }
        if tableViewData[indexPath.section].data == "Jewellery" && indexPath.row == 4 {
        performSegue(withIdentifier: "segueSearchToJewelleryOther", sender: indexPath)
        }
        //Art deco
        if tableViewData[indexPath.section].data == "Art deco" && indexPath.row == 1 {
        performSegue(withIdentifier: "segueSearchToArtDeco", sender: indexPath)
        }
        if tableViewData[indexPath.section].data == "Art deco" && indexPath.row == 2 {
        performSegue(withIdentifier: "segueSearchToArtDecoOther", sender: indexPath)
        }
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Mode
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
        }else if segue.identifier == "segueSearchToModeOther" {
            
            let destination = segue.destination as! CategoryClothesViewController
            destination.sousCategorieName = "Other"
        }
        //High tech
        else if segue.identifier == "segueSearchToPc" {
            
            let destination = segue.destination as! CategoryClothesViewController
            destination.sousCategorieName = "Pc"
        }
        else if segue.identifier == "segueSearchToTv" {
            
            let destination = segue.destination as! CategoryClothesViewController
            destination.sousCategorieName = "Tv"
        }
        else if segue.identifier == "segueSearchToComputersAccessories" {
            
            let destination = segue.destination as! CategoryClothesViewController
            destination.sousCategorieName = "Computers' accessories"
        }
        else if segue.identifier == "segueSearchToHighTechOther" {
            
            let destination = segue.destination as! CategoryClothesViewController
            destination.sousCategorieName = "Other"
        }
        //Beauty
        else if segue.identifier == "segueSearchToMakeUp" {
            
            let destination = segue.destination as! CategoryClothesViewController
            destination.sousCategorieName = "make up"
        }
        else if segue.identifier == "segueSearchToArtSupplies" {
            
            let destination = segue.destination as! CategoryClothesViewController
            destination.sousCategorieName = "Art Supplies"
        }
        else if segue.identifier == "segueSearchToBeautyOther" {
            
            let destination = segue.destination as! CategoryClothesViewController
            destination.sousCategorieName = "Other"
        }
        //Baby
        else if segue.identifier == "segueSearchToBaby" {
            
            let destination = segue.destination as! CategoryClothesViewController
            destination.sousCategorieName = "Baby"
        }
        //Jewellery
        else if segue.identifier == "segueSearchToEarrings" {
            
            let destination = segue.destination as! CategoryClothesViewController
            destination.sousCategorieName = "earrings"
        }
        else if segue.identifier == "segueSearchToRings" {
            
            let destination = segue.destination as! CategoryClothesViewController
            destination.sousCategorieName = "rings"
        }
        else if segue.identifier == "segueSearchToBracelets" {
            
            let destination = segue.destination as! CategoryClothesViewController
            destination.sousCategorieName = "bracelets"
        }
        else if segue.identifier == "segueSearchToJewelleryOther" {
            
            let destination = segue.destination as! CategoryClothesViewController
            destination.sousCategorieName = "Other"
        }
        //Art deco
        else if segue.identifier == "segueSearchToArtDeco" {
            
            let destination = segue.destination as! CategoryClothesViewController
            destination.sousCategorieName = "art deco"
        }
        else if segue.identifier == "segueSearchToArtDecoOther" {
            
            let destination = segue.destination as! CategoryClothesViewController
            destination.sousCategorieName = "Other"
        }
    }
}

