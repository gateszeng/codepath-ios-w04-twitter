//
//  ProfileViewController.swift
//  tweeter
//
//  Created by Gates Zeng on 3/6/17.
//  Copyright © 2017 Gates Zeng. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var numTweetsLabel: UILabel!
    @IBOutlet weak var numFollowingLabel: UILabel!
    @IBOutlet weak var numFollowersLabel: UILabel!

    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        coverImageView.setImageWith(user.coverURL!)
        profileImageView.setImageWith(user.profileURL!)
        nameLabel.text = user.name
        screenNameLabel.text = user.screenname
        numTweetsLabel.text = user.tweetCount!
        numFollowersLabel.text = user.followersCount!
        numFollowingLabel.text = user.followingCount!
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
