//
//  Favourit.swift
//  showapp
//
//  Created by rami on 10/12/2021.
//

import Foundation
struct Favorites: Codable {
    var favourite: [Favorite]?
}

struct Favorite: Codable {
    var _id:String
    var refArticle:String?
    var refuser:String?
    var name:String?
    var price:String?
    var favPicture:String?
    var __v:Int
}
