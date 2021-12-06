//
//  News.swift
//  showapp
//
//  Created by rami on 6/12/2021.
//

import Foundation

struct News: Codable {
    var news: [New]?
}

struct New: Codable {
    var _id:String
    var BrandsName:String?
    var title:String?
    var newsPicture:String?
    var __v:Int
}
