//
//  AddArticleService.swift
//  showapp
//
//  Created by rami on 29/11/2021.
//

import Foundation
import Alamofire
import UIKit
class articleService {
    struct Media {
        let key: String
        let filename: String
        let data: Data
        let mimeType: String
        init?(withImage image: UIImage, forKey key: String) {
            self.key = key
            self.mimeType = "image/jpeg"
            self.filename = "imagefile.jpg"
            guard let data = image.jpegData(compressionQuality: 0.7) else { return nil }
            self.data = data
        }
    }
    static func addArticleToServer(image: UIImage,parameters:[String:Any]) {
       
       guard let mediaImage = Media(withImage: image, forKey: "articlePicture") else { return }
       guard let url = URL(string: "http://172.31.32.1:3000/articles") else { return }
       var request = URLRequest(url: url)
       request.httpMethod = "POST"
       //create boundary
       let boundary = generateBoundary()
       //set content type
       request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
       //call createDataBody method
       let dataBody = createDataBody(withParameters: parameters, media: [mediaImage], boundary: boundary)
       request.httpBody = dataBody
       let session = URLSession.shared
       session.dataTask(with: request) { (data, response, error) in
          if let response = response {
             print(response)
          }
          if let data = data {
             do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
             } catch {
                print(error)
             }
          }
       }.resume()
    }
    
    
    
    static func createDataBody(withParameters params: Parameters?, media: [Media]?, boundary: String) -> Data {
       let lineBreak = "\r\n"
       var body = Data()
       if let parameters = params {
          for (key, value) in parameters {
             body.append("--\(boundary + lineBreak)")
             body.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)")
             body.append("\(value as! String + lineBreak)")
          }
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
    
    
    static func generateBoundary() -> String {
       return "Boundary-\(NSUUID().uuidString)"
    }
    
    
    
    
    func getArticleByType(ArticleType:String ,callback: @escaping (Bool,Articles?)->Void){
           
        guard let url = URL(string: "http://172.31.32.1:3000/articles/type/"+ArticleType) else{
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
                        
                        let test = try decoder.decode(Articles.self, from: data!)
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
    
    
    
    func getArticle( callback: @escaping (Bool,Articles?)->Void){
           
            guard let url = URL(string: "http://172.31.32.1:3000/articles") else{
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
                        
                        let test = try decoder.decode(Articles.self, from: data!)
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
    
    
    func getCompanyArticle( callback: @escaping (Bool,Articles?)->Void){
           
            guard let url = URL(string: "http://172.31.32.1:3000/articles/company/" + UserDefaults.standard.string(forKey: "_id")!) else{
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
                        
                        let test = try decoder.decode(Articles.self, from: data!)
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
    
    func getBrandArticle(BrandId:String, callback: @escaping (Bool,Articles?)->Void){
           
            guard let url = URL(string: "http://172.31.32.1:3000/articles/company/"+BrandId ) else{
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
                        
                        let test = try decoder.decode(Articles.self, from: data!)
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
    
    
    
    
    static func addArticleToFavourit(image: UIImage,parameters:[String:Any]) {
       
       guard let mediaImage = Media(withImage: image, forKey: "favPicture") else { return }
       guard let url = URL(string: "http://172.31.32.1:3000/favorites/add") else { return }
       var request = URLRequest(url: url)
       request.httpMethod = "POST"
       //create boundary
       let boundary = generateBoundary()
       //set content type
       request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
       //call createDataBody method
       let dataBody = createDataBody(withParameters: parameters, media: [mediaImage], boundary: boundary)
       request.httpBody = dataBody
       let session = URLSession.shared
       session.dataTask(with: request) { (data, response, error) in
          if let response = response {
             print(response)
          }
          if let data = data {
             do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
             } catch {
                print(error)
             }
          }
       }.resume()
    }
    
    
    func getUserFavourites( callback: @escaping (Bool,Favorites?)->Void){
               
        guard let url = URL(string: "http://172.31.32.1:3000/favorites/refuser/"+UserDefaults.standard.string(forKey: "_id")!) else{
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
                            
                            let test = try decoder.decode(Favorites.self, from: data!)
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
    
    func getUserCarts( callback: @escaping (Bool,Factures?)->Void){
               
        guard let url = URL(string: "http://172.31.32.1:3000/factures/refuser/"+UserDefaults.standard.string(forKey: "_id")!) else{
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
                            
                            let test = try decoder.decode(Factures.self, from: data!)
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


