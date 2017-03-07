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
    
    
    // singleton
    static let sharedInstance = TwitterClient(baseURL: URL(string: "https://api.twitter.com"), consumerKey: "LxPkUGN5gBgehW5Ga464yFlSa", consumerSecret: "iUZ8CJaOkwKV2tXl3dT83DQkij5EawhMfCb52ooEBzf9dMu8MQ")
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((Error) ->())?

    // login takes closures for success and failure
    func login(success: @escaping () -> (), failure: @escaping (Error) -> ()) {
        loginSuccess = success
        loginFailure = failure
        
        // first log out
        TwitterClient.sharedInstance?.deauthorize()
        
        // then fetch the request token to get authorization link
        TwitterClient.sharedInstance?.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: URL(string: "tweeter://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential?) -> Void in
            let url = URL(string: "https://api.twitter.com/oauth/authorize?=oauth_token=\(requestToken!.token!)")
            UIApplication.shared.open(url!)
            
            }, failure: { (error: Error?) -> Void in
                print("error: \(error!.localizedDescription)")
                self.loginFailure!(error!)
        })
    }
    
    func logout() {
        User.currentUser = nil
        deauthorize()
        
        // sends messages that allows many parts of the application to receive
        NotificationCenter.default.post(name: User.userDidLogoutNotification, object: nil)
    }
    
    // handle the url opening to app and get access token
    func handleOpenUrl(url: URL) {
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        
        fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken!, success: { (accessToken: BDBOAuth1Credential?) in
            
            // get the current account
            self.currentAccount(success: { (user: User) in
                User.currentUser = user
                self.loginSuccess?()
                
                }, failure: { (error: Error) in
                    self.loginFailure?(error)
            })
            
            }, failure: { (error: Error?) in
                print("error: \(error!.localizedDescription)")
                self.loginFailure?(error!)
        })
    }
    
    // if successful, return user obj, otherwise error
    func currentAccount(success: @escaping (User) -> (), failure: @escaping (Error) -> ()) {
        get("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            print("account: \(response)")
            
            let userDictionary = response as! NSDictionary
            let user = User(dictionary: userDictionary)

            success(user)
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            failure(error)
        })
    }
    
    func homeTimeline(success: @escaping ([Tweet]) -> (), failure: @escaping (Error) -> ()) {
        get("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            let dictionaries = response as! [NSDictionary]
            
            let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries)
            
            success(tweets)
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            failure(error)
                
        })
    }
    
    func sendFavorite(id: String) {
        post("1.1/favorites/create.json?id=" + id, parameters: nil, progress: nil, success: nil, failure: nil)
        print("favorite sent")
    }
    
    func sendRetweet(id: String) {
        post("1.1/statuses/retweet/" + id + ".json", parameters: nil, progress: nil, success: nil, failure: nil)
        print("retweet sent")
    }
    
    func postNewTweet(tweetString: String) {
        let encodedTweet = tweetString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        print(encodedTweet)
        post("1.1/statuses/update.json?status=\(encodedTweet)" , parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            // post success code here
            print("status updated with: " + tweetString)
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            print(error.localizedDescription)
            print("status update failed")
        })
    }
    
    
    
}
