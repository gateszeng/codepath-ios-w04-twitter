//
//  User.swift
//  tweeter
//
//  Created by Gates Zeng on 2/27/17.
//  Copyright © 2017 Gates Zeng. All rights reserved.
//

import UIKit

class User: NSObject {
    
    static let userDidLogoutNotification = NSNotification.Name("userDidLogout")
    
    var name: String?
    var screenname: String?
    var profileURL: URL?
    var tagline: String?
    
    var dictionary: NSDictionary?
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        
        let profileURLString = dictionary["profile_image_url_https"] as? String
        if let profileURLString = profileURLString {
            profileURL = URL(string: profileURLString)
        }
        
        tagline = dictionary["description"] as? String
        
    }
    
    // hidden currentUser object
    static var _currentUser: User?
    
    class var currentUser: User? {
        
        // getter that will grab from UserDefaults
        get {
            // if the currentUser reference is nil, then check the UserDefaults
            if _currentUser != nil {
                let defaults = UserDefaults.standard
                
                let userData = defaults.object(forKey: "currentUserData") as?NSData
                
                // if there exists userData stored, then convert from JSON to User object
                if let userData = userData {
                    
                    let dictionary = try! JSONSerialization.jsonObject(with: userData as Data, options: []) as! NSDictionary
                    
                    _currentUser = User(dictionary: dictionary)
                }
            }
            return _currentUser
        }
        
        // setter that will set the current user based off the
        set(user) {
            _currentUser = user
            let defaults = UserDefaults.standard
            
            if let user = user {
                
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                defaults.set(data, forKey: "currentUserData")
                
            } else {
                
                defaults.set(nil, forKey: "currentUserData")
                
            }
            
            defaults.synchronize()
            
        }
    }
}
