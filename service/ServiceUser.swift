//
//  ServiceUser.swift
//  showapp
//
//  Created by rami on 22/11/2021.
//

import Foundation
import UIKit
class ServiceUser {
    
    
    
    //test getting user info
    func loginWithGoogleAndFacebook(email: String,callback: @escaping (Bool,Any?)->Void){
            
            let params = [
                "email": email
            ]
            guard let url = URL(string: "http://192.168.1.13:3000/users/loginSocial") else{
                return
            }
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
            let session = URLSession.shared.dataTask(with: request){
                data, response, error in
                DispatchQueue.main.async {
                    if error != nil{
                        print(error)
                    }else {
                        //print("++++++++++++",data)
                        if let jsonRes  = try? JSONSerialization.jsonObject(with: data!, options:[] ) as? [String: Any]{
                            if jsonRes["token"] != nil {
                               
                                
                                UserDefaults.standard.setValue(jsonRes["token"], forKey: "tokenConnexion")
                            }
                            if let reponse = jsonRes["user"] as? [String: Any]{
                                for (key,value) in reponse{
                                    UserDefaults.standard.setValue(value, forKey: key)
                                }
                                UserDefaults.standard.setValue("", forKey: "password")
                                callback(true,"good")
                                
                            }else{
                                callback(false,"pas inscrit")
                            }
                        }else{
                            callback(false,nil)
                        }
                    }
                }
                
            }.resume()
            
        }
    
    struct Media {
        let key: String
        let filename: String
        let data: Data
        let mimeType: String
        init?(withImage image: UIImage, forKey key: String) {
            self.key = key
            self.mimeType = "image/jpeg"
            self.filename = "profilePicture.jpg"
            guard let data = image.jpegData(compressionQuality: 0.7) else { return nil }
            self.data = data
        }
    }
    
    func CreationCompteFacebookOrGoogle(user:User, image :UIImage, callback: @escaping (Bool,String?)->Void){
            
            guard let mediaImage = Media(withImage: image, forKey: "profilePicture") else { return }
            guard let url = URL(string: "http://192.168.1.13:3000/users/signupMedia") else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            //create boundary
            let boundary = generateBoundary()
            //set content type
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            //call createDataBody method
            
            let dataBody = DataBodyWithoutPass(user:user, media: [mediaImage], boundary: boundary)
            print(dataBody)
            request.httpBody = dataBody
            let session = URLSession.shared
            session.dataTask(with: request) { (data, response, error) in
                DispatchQueue.main.async {
                    if let data = data {
                        do {
                           // print("data lenna ",data)
                            if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]{
                                if let reponse = json["reponse"] as? String{
                                    if (reponse.contains("email")){
                                        callback(false,"mail existant")
                                    }
                                    else{
                                        if let connexionToken = json["token"] as? String{
                                            //print(connexionToken)
                                            UserDefaults.standard.setValue(connexionToken, forKey: "token")
                                        }
                                        if let validUser = json["user"] as? [String:Any]{
                                            for (key,value) in validUser{
                                                //print("cle = ",key, "Valeur =",value)
                                                UserDefaults.standard.setValue(value, forKey: key)
                                            }
                                        }
                                        callback(true,"ok")
                                    }
                                }
                            }
                        } catch {
                            callback(false,nil)
                        }
                    }else{
                        callback(false,nil)}
                    
                }
            }.resume()
        }
    
    
    
    func DataBodyWithoutPass(user:User, media: [Media]?, boundary: String) -> Data {
            let lineBreak = "\r\n"
            var body = Data()
        
            body.append("--\(boundary + lineBreak)")
            body.append("Content-Disposition: form-data; name=\"email\"\(lineBreak + lineBreak)")
            body.append("\(user.email + lineBreak)")
        
        
            if let media = media {
                for photo in media {
                    body.append("--\(boundary + lineBreak)")
                    body.append("Content-Disposition: form-data; name=\"\(photo.key)\"; filename=\"\(photo.filename)\"\(lineBreak)")
                    body.append("Content-Type: \(photo.mimeType + lineBreak + lineBreak)")
                    body.append(photo.data)
                    body.append(lineBreak)
                }
            }
        
            body.append("--\(boundary + lineBreak)")
            body.append("Content-Disposition: form-data; name=\"firstName\"\(lineBreak + lineBreak)")
            body.append("\(user.firstName + lineBreak)")
            
            
            
            body.append("--\(boundary + lineBreak)")
            body.append("Content-Disposition: form-data; name=\"lastName\"\(lineBreak + lineBreak)")
            body.append("\(user.lastName + lineBreak)")
            
            
            body.append("--\(boundary)--\(lineBreak)")
        print("body body body : ",	body)
            return body
        }
    
    func generateBoundary() -> String {
            return "Boundary-\(NSUUID().uuidString)"
        }
    
    
    
    func UpdateProfil(user:User, image :UIImage, callback: @escaping (Bool,String?)->Void){
            guard let mediaImage = Media(withImage: image, forKey: "profilePicture") else { return }
            guard let url = URL(string: "http://192.168.1.13:3000/users/"+UserDefaults.standard.string(forKey: "_id")!) else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "PUT"
            //create boundary
            
            let boundary = generateBoundary()
            //set content type
            let token = UserDefaults.standard.string(forKey: "token")!
            //print("token",token)
            request.setValue( "Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            
            
            //call createDataBody method
            
            let dataBody = DataBody(user:user, media: [mediaImage], boundary: boundary)
            request.httpBody = dataBody
            let session = URLSession.shared
            session.dataTask(with: request) { (data, response, error) in
                DispatchQueue.main.async {
                    if let response = response {
                    }
                    if let data = data {
                        do {
                            if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]{
                                print("json",json)
                                print("hedha star el data")
                                if let reponse = json["message"] as? String{
                                    print(json)
                                    print("blablabla")
                                    if (reponse.contains("user modified !")){
                                        if let validUser = json["user"] as? [String:Any]{
                                            print("cc")
                                            for (key,value) in validUser{
                                                UserDefaults.standard.setValue(value, forKey: key)
                                                print("cc2")
                                            }
                                        }
                                        callback(true,"user modified !")
                                       
                                    }
                                    else{
                                        callback(false,"ICIIII")
                                    }
                                } else{
                                    callback(false,"erreur")
                                }
                            }
                        } catch {
                            callback(false,nil)
                        }
                    }else{
                        callback(false,nil)}}
            }.resume()
        }
    
    
    
    func DataBody(user:User, media: [Media]?, boundary: String) -> Data {
            let lineBreak = "\r\n"
            var body = Data()
            body.append("--\(boundary + lineBreak)")
            body.append("Content-Disposition: form-data; name=\"firstName\"\(lineBreak + lineBreak)")
            body.append("\(user.firstName + lineBreak)")
            
            
            
            body.append("--\(boundary + lineBreak)")
            body.append("Content-Disposition: form-data; name=\"prenom\"\(lineBreak + lineBreak)")
            body.append("\(user.lastName + lineBreak)")
            
            
            body.append("--\(boundary + lineBreak)")
            body.append("Content-Disposition: form-data; name=\"lastName\"\(lineBreak + lineBreak)")
            body.append("\(user.email + lineBreak)")
            if !(user.password ?? "").isEmpty{
                body.append("--\(boundary + lineBreak)")
                body.append("Content-Disposition: form-data; name=\"password\"\(lineBreak + lineBreak)")
                body.append("\(user.password + lineBreak)")
            }
            
           
            
            if let media = media {
                for photo in media {
                    body.append("--\(boundary + lineBreak)")
                    body.append("Content-Disposition: form-data; name=\"\(photo.key)\"; filename=\"\(photo.filename)\"\(lineBreak)")
                    body.append("Content-Type: \(photo.mimeType + lineBreak + lineBreak)")
                    body.append(photo.data)
                    body.append(lineBreak)
                }
            }
            body.append("--\(boundary)--\(lineBreak)")
            return body
        }
      
    
    
    
    func forgotPassword (email:String, callback: @escaping (Bool,Any?)->Void){
            
            guard let url = URL(string: "http://192.168.1.13:3000/users/reset") else {return}
            var request = URLRequest(url: url)
            let params = [
                "email": email
            ]
            request.httpMethod = "POST"
            request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
            let session = URLSession.shared.dataTask(with: request){
                data, response, error in
                if let json = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String:Any]{
                    if (json["succes"] as! Int == 1){
                        callback(true,json["token"] as! String)

                    }else{
                        callback(false,"error")
                    }
                }else{
                    callback(false,"erreur")
                }
            }.resume()
        }
        
        func resetPass(password : String, email:String, code:String , callback: @escaping (Bool,Any?)->Void){
            
            guard let url = URL(string: "http://192.168.1.13:3000/users/reset") else {return}
            var request = URLRequest(url: url)
            let params = [
                "email": email,
                "code": code,
                "password": password
                
                
            ]
            
            request.httpMethod = "PATCH"
            request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
            let session = URLSession.shared.dataTask(with: request){
                data, response, error in
                if let json = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String:Any]{
                    if json["message"] as! String == "Your password has been successfully reset"{
                        callback(true,"reset done")
                    }
                    else{
                        callback(false,json)
                    }
                }
            }.resume()
    }
    
    func getAllUsers( callback: @escaping (Bool,Users?)->Void){
                   print("bdina")
            guard let url = URL(string: "http://192.168.1.13:3000/users") else{
                        return
                    }
                    var request = URLRequest(url: url)
                    request.httpMethod = "GET"
                    request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
                    let session = URLSession.shared.dataTask(with: request){
                        data, response, error in
                        DispatchQueue.main.async {
                        if error == nil && data != nil{
                            
                            let decoder = JSONDecoder()
                            do {
                                
                                let test = try decoder.decode(Users.self, from: data!)
                                print("kamalna")
                                callback(true,test)
                            } catch  {
                                print(error)
                                callback(false,nil)
                            }
                        }else{
                            callback(false,nil)}
                        
                     
                        
                        }
                    }.resume()
                }
    
    

    
    
    
}
