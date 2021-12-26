//
//  ContentView.swift
//  showapp
//
//  Created by rami on 25/12/2021.
//

import SwiftUI
import SendBirdUIKit

struct ContentView: View {
    init() {
        
        // Initialize the SendbirdSDK with your application id,
        // also found in the Sendbird dashboard
        let appID = "57E64C12-D528-4AC6-AE11-47E5C8ABB26E"
        SBUMain.initialize(applicationId: appID) {
            // DB migration has started.
        } completionHandler: { error in
            // If DB migration is successful, proceed to the next step.
            // If DB migration fails, an error exists.
        }
        
        // After your user has authenticated, use a string
        // identifier unique to that user to pass to Sendbird.
        SBUGlobals.CurrentUser = SBUUser(userId: "userA")

        // Connect with Sendbird now that the CurrentUser is set
        SBUMain.connect { (user, error) in
            
            // user object will be an instance of SBDUser
            guard let _ = user else {
                print("ContentView: init: connect: ERROR: \(String(describing: error))")
                return
            }
        }
    }
    
    var body: some View {
        ChannelListViewContainer()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
