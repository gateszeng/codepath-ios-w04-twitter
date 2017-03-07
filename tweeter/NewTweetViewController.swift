//
//  NewTweetViewController.swift
//  tweeter
//
//  Created by Gates Zeng on 3/6/17.
//  Copyright © 2017 Gates Zeng. All rights reserved.
//

import UIKit

class NewTweetViewController: UIViewController {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var tweetField: UITextField!
    
    var user = User.currentUser

    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImageView.setImageWith((user?.profileURL)!)
        nameLabel.text = user?.name
        screenNameLabel.text = user?.screenname

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func onPostButton(_ sender: Any) {
        TwitterClient.sharedInstance?.postNewTweet(tweetString: tweetField.text!)
        dismiss(animated: true, completion: nil)
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
