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
            guard let url = URL(string: "http://172.27.32.1:3000/login") else{
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
                        print("error")
                    }else {
                        //print("++++++++++++",data)
                        if let jsonRes  = try? JSONSerialization.jsonObject(with: data!, options:[] ) as? [String: Any]{
                           print("probleme ici", jsonRes)
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
            guard let url = URL(string: "http://172.27.32.1:3000/signup") else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            //create boundary
            let boundary = generateBoundary()
            //set content type
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            //call createDataBody method
            
            let dataBody = DataBodyWithoutPass(user:user, media: [mediaImage], boundary: boundary)
            //print(dataBody)
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
            body.append("Content-Disposition: form-data; name=\"nom\"\(lineBreak + lineBreak)")
            body.append("\(user.firstName + lineBreak)")
            
            
            
            body.append("--\(boundary + lineBreak)")
            body.append("Content-Disposition: form-data; name=\"prenom\"\(lineBreak + lineBreak)")
            body.append("\(user.lastName + lineBreak)")
            
            
            body.append("--\(boundary)--\(lineBreak)")
            return body
        }
    
    func generateBoundary() -> String {
            return "Boundary-\(NSUUID().uuidString)"
        }
    
}
