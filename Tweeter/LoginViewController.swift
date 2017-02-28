//
//  LoginViewController.swift
//  tweeter
//
//  Created by Gates Zeng on 2/27/17.
//  Copyright © 2017 Gates Zeng. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLoginButton(_ sender: AnyObject) {
        let twitterClient = BDBOAuth1SessionManager(baseURL: URL(string: "https://api.twitter.com"), consumerKey: "LxPkUGN5gBgehW5Ga464yFlSa", consumerSecret: "iUZ8CJaOkwKV2tXl3dT83DQkij5EawhMfCb52ooEBzf9dMu8MQ")
        
        twitterClient?.deauthorize()
        twitterClient?.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: URL(string: "tweeter://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential?) -> Void in
            print("I got a token")
            
            let url = URL(string: "https://api.twitter.com/oauth/authorize?=oauth_token=\(requestToken!.token!)")
            UIApplication.shared.open(url!)
            
            }, failure: { (error: Error?) -> Void in
                print("error: \(error!.localizedDescription)")
        })
        

        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
