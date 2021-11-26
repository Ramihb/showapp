//
//  User.swift
//  showapp
//
//  Created by rami on 24/11/2021.
//

import Foundation

struct User: Decodable {
    let email: String
    let password: String
    let phoneNumber: Int
    let firstName: String
    let lastName: String
    
}
