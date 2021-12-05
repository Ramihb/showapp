//
//  test.swift
//  showapp
//
//  Created by rami on 5/12/2021.
//

import Alamofire
import UIKit
class test {
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
        static func uploadImageToServer(image: UIImage,parameters:[String:Any], callback: @escaping (Bool,String?)->Void) {
           
           guard let mediaImage = Media(withImage: image, forKey: "profilePicture") else { return }
           guard let url = URL(string: "http://172.27.32.1:3000/users/"+UserDefaults.standard.string(forKey: "_id")!) else { return }
           var request = URLRequest(url: url)
           request.httpMethod = "PUT"
           //create boundary
           let boundary = generateBoundary()
           //set content type
           request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
           //call createDataBody method
           let dataBody = createDataBody(withParameters: parameters, media: [mediaImage], boundary: boundary)
           request.httpBody = dataBody
           let session = URLSession.shared
           session.dataTask(with: request) { (data, response, error) in
               DispatchQueue.main.async {
              if let response = response {
                 //print(response)
              }
              if let data = data {
                 do {
                     if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]{
                        print("json",json)
                         if let reponse = json["message"] as? String{
//                             print(json)
//                             print("blablabla")
                             if (reponse.contains("user modified !")){
                                 
                                 if let validPhoto = json["profilePicture"] as? String{
                                     print("aaaaaa",validPhoto)
                                 }
                                 if let validUser = json["user"] as? [String:Any]{
                                     for (key,value) in validUser{
                                         UserDefaults.standard.setValue(value, forKey: key)
                                         //print("cc")
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
                    print(error)
                 }
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
}
