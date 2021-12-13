//
//  Company.swift
//  showapp
//
//  Created by rami on 27/11/2021.
//

import Foundation

struct Companys: Codable {
    var companys: [Company]?
}

struct Company: Codable {
    var _id: String?
    var emailCompany: String?
    var passwordCompany: String?
    var phoneNumberCompany: Int
    var lastNameCompany: String?
    var firstNameCompany: String?
    var categoryCompany: String?
    var brandPicCompany: String?
    var businessNameCompany: String?
    var verifiedCompany: Bool
    var __v:Int
}
