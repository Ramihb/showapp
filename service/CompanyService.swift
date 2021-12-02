//
//  CompanyService.swift
//  showapp
//
//  Created by rami on 27/11/2021.
//

import Foundation
import Alamofire

class ApiService
{
    static func getPostString(params:[String:Any]) -> String
    {
        var data = [String]()
        for(key, value) in params
        {
            data.append(key + "=\(value)")
        }
        return data.map { String($0) }.joined(separator: "&")
    }

    static func callPost(url:URL, params:[String:Any], finish: @escaping ((message:String, data:Data?)) -> Void)
    {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        let postString = self.getPostString(params: params)
        request.httpBody = postString.data(using: .utf8)

        var result:(message:String, data:Data?) = (message: "Fail", data: nil)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in

            if(error != nil)
            {
                result.message = "Fail Error not null : \(error.debugDescription)"
            }
            else
            {
                result.message = "Success"
                result.data = data
            }

            finish(result)
        }
        task.resume()
    }
    
    
    
    
    
}


import UIKit
class ApiCompanyService {
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
    static func uploadImageToServer(image: UIImage,parameters:[String:Any]) {
       
       guard let mediaImage = Media(withImage: image, forKey: "brandPicCompany") else { return }
       guard let url = URL(string: "http://172.27.32.1:3000/company/signup") else { return }
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
    
    
    
    
    
}

