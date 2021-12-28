//
//  User.swift
//  showapp
//
//  Created by rami on 24/11/2021.
//

import Foundation

struct Users: Codable {
    var users: [User]?
}

struct User: Codable {
    var _id:String
    var email: String
    var password: String
    var phoneNumber: String
    var profilePicture:String
    var firstName: String
    let lastName: String
    var verified:Bool
    var __v:Int
    
    
    init(id:String, email:String,password:String,phoneNumber:String, profilePicture:String,firstName:String,lastName:String,verified:Bool,__v:Int) {
            self._id = id
            self.email = email
            self.password=password
            self.phoneNumber=phoneNumber
            self.profilePicture=profilePicture
            self.firstName=firstName
            self.lastName=lastName
            self.verified = verified
            self.__v = 0
        }
    
//    init(id:String, email:String,profilePicture:String,firstName:String,lastName:String,isVerified:Bool,__v:Int) {
//            self._id = id
//            self.email = email
//            self.profilePicture = profilePicture
//            self.firstName = firstName
//            self.lastName = lastName
//            self.isVerified = isVerified
//            self.__v = 0
//    }
    
}
