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
    var coverURL: URL?
    var tagline: String?
    var tweetCount: String?
    var followersCount: String?
    var followingCount: String?
    
    
    var dictionary: NSDictionary?
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        
        tweetCount = dictionary["statuses_count"] as? String
        followersCount = dictionary["followers_count"] as? String
        followingCount = dictionary["friends_count"] as? String
        
        let profileURLString = dictionary["profile_image_url_https"] as? String
        if let profileURLString = profileURLString {
            profileURL = URL(string: profileURLString)
        }
        let coverURLString = dictionary["profile_background_image_url_https"] as? String
        if let coverURLString = coverURLString {
            coverURL = URL(string: coverURLString)
        }
        
        tagline = dictionary["description"] as? String
        
    }
    
    // hidden currentUser class variable
    static var _currentUser: User?
    
    class var currentUser: User? {
        
        // getter that will grab from UserDefaults
        get {
            let defaults = UserDefaults.standard

            // if the currentUser reference is nil, then check the UserDefaults
            if _currentUser == nil {
                
                guard let defaultData = defaults.object(forKey: "currentUserData") else {
                    return nil
                }
                
                let userData = defaultData as? Data
                
                // if there exists userData stored, then convert from JSON to User object
                if let userData = userData {
                    let dictionary = try! JSONSerialization.jsonObject(with: userData, options: []) as! NSDictionary
                    
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
                
                let userData = defaults.object(forKey: "currentUserData") as? Data
                
                let dictionary = try! JSONSerialization.jsonObject(with: userData!, options: []) as! NSDictionary

                print("converted to json")
                print(dictionary)
                
            } else {
                defaults.removeObject(forKey: "currentUserData")
            }
            
            defaults.synchronize()
            
        }
    }
}
