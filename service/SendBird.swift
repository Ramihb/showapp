//
//  SendBird.swift
//  showapp
//
//  Created by rami on 26/12/2021.
//

import Foundation
import UIKit
import SendBirdSDK

class SendBirdApi  {
    
    
    
    func SendBirdCreateAccount (user_id:String,nickname:String,profile_url:String){
        let params = [
            "user_id": user_id,
            "nickname": nickname,
            "profile_url": profile_url
        ]
        guard let url = URL(string: "https://api-CF932073-4853-4C10-935F-454F5C225178.sendbird.com/v3/users") else{
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.setValue( "26e2e054998fd912c3db886fa793080c912891e5", forHTTPHeaderField: "Api-Token")
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        let session = URLSession.shared.dataTask(with: request){
            data, response, error in
            DispatchQueue.main.async {
                if error != nil{
                    print("error")
                }else {
                    if let jsonRes  = try? JSONSerialization.jsonObject(with: data!, options:[] ) as? [String: Any]{
                        print(jsonRes)
                           
                            
                        }
                        
                    }
                }
            
            
        }.resume()
    }
    func createChannel (name:String , callback: @escaping (Bool,Any?)->Void){
            
            let params = [
                "name": name
            ]
            guard let url = URL(string: "https://api-CF932073-4853-4C10-935F-454F5C225178.sendbird.com/v3/open_channels") else{
                return
            }
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
            request.setValue( "26e2e054998fd912c3db886fa793080c912891e5", forHTTPHeaderField: "Api-Token")
            request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
            let session = URLSession.shared.dataTask(with: request){
                data, response, error in
                DispatchQueue.main.async {
                    if error != nil{
                        print("error")
                    }else {
                        if let jsonRes  = try? JSONSerialization.jsonObject(with: data!, options:[] ) as? [String: Any]{
                            print(jsonRes["channel_url"])
                            callback(true,jsonRes["channel_url"])
                                
                            }
                        else{
                            callback(false,"jsonRes")
                        }
                            
                        }
                    }
                
                
            }.resume()
        }
        func deleteUser (id:String){
            
            guard let url = URL(string: "https://api-CF932073-4853-4C10-935F-454F5C225178.sendbird.com/v3/users/"+id) else{
                return
            }
            var request = URLRequest(url: url)
            request.httpMethod = "DELETE"
            request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
            request.setValue( "26e2e054998fd912c3db886fa793080c912891e5", forHTTPHeaderField: "Api-Token")
            let session = URLSession.shared.dataTask(with: request){
                data, response, error in
                DispatchQueue.main.async {
                    if error != nil{
                        print("error")
                    }else {
                        if let jsonRes  = try? JSONSerialization.jsonObject(with: data!, options:[] ) as? [String: Any]{
                            print(jsonRes)
                                
                            }
                            
                        }
                    }
                
                
            }.resume()
        }
}
