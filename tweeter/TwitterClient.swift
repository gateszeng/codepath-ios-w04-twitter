//
//  TwitterClient.swift
//  tweeter
//
//  Created by Gates Zeng on 2/28/17.
//  Copyright © 2017 Gates Zeng. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    
    static let sharedInstance = TwitterClient(baseURL: URL(string: "https://api.twitter.com"), consumerKey: "LxPkUGN5gBgehW5Ga464yFlSa", consumerSecret: "iUZ8CJaOkwKV2tXl3dT83DQkij5EawhMfCb52ooEBzf9dMu8MQ")
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((Error) ->())?

    func login(success: @escaping () -> (), failure: @escaping (Error) -> ()) {
        loginSuccess = success
        loginFailure = failure
        
        TwitterClient.sharedInstance?.deauthorize()
        TwitterClient.sharedInstance?.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: URL(string: "tweeter://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential?) -> Void in
            let url = URL(string: "https://api.twitter.com/oauth/authorize?=oauth_token=\(requestToken!.token!)")
            UIApplication.shared.open(url!)
            
            }, failure: { (error: Error?) -> Void in
                print("error: \(error!.localizedDescription)")
                self.loginFailure!(error!)
        })
    }
    
    func handleOpenUrl(url: URL) {
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        
        fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken!, success: { (accessToken: BDBOAuth1Credential?) in
            self.loginSuccess?()
            
            }, failure: { (error: Error?) in
                print("error: \(error!.localizedDescription)")
                self.loginFailure?(error!)
        })
    }
    
    func currentAccount() {
        get("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            print("account: \(response)")
            
            let userDictionary = response as! NSDictionary
            
            let user = User(dictionary: userDictionary)
            
            print("name: \(user.name)")
            print("screenname: \(user.screenname)")
            print("profile url: \(user.profileURL)")
            print("description: \(user.tagline)")
            
            }, failure: { (task: URLSessionDataTask?, error: Error) in
        })
    }
    
    func homeTimeline(success: @escaping ([Tweet]) -> (), failure: @escaping (Error) -> ()) {
        get("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            let dictionaries = response as! [NSDictionary]
            
            let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries)
            
            success(tweets)
        }, failure: { (twwask: URLSessionDataTask?, error: Error) in
            failure(error)
                
        })
    }
}
