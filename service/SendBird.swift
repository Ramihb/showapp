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
        guard let url = URL(string: "https://api-57E64C12-D528-4AC6-AE11-47E5C8ABB26E.sendbird.com/v3/users") else{
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.setValue( "07bfd3d7be8af5132da886ef0d6c8823abb3a1d6", forHTTPHeaderField: "Api-Token")
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
}
