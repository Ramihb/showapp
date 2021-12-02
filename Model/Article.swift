//
//  Article.swift
//  showapp
//
//  Created by rami on 29/11/2021.
//

import Foundation

struct Articles: Codable {
    var articles: [Article]?
}

struct Article: Codable {
    var _id:String
    var name:String?
    var category:String?
    var price:String?
    var articlePicture:String?
    var quantity:Int
    var type:String?
    var __v:Int
}
