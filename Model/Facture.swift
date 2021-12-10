//
//  Facture.swift
//  showapp
//
//  Created by rami on 10/12/2021.
//

import Foundation

struct Factures: Codable {
    var factures: [Facture]?
}

struct Facture: Codable {
    var _id:String
    var name:String?
    var price:String?
    var refArticle:String?
    var refuser:String?
    var qte:String?
    var cartPicture:String?
    var __v:Int
}
