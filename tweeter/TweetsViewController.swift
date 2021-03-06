//
//  TweetsViewController.swift
//  tweeter
//
//  Created by Gates Zeng on 2/28/17.
//  Copyright © 2017 Gates Zeng. All rights reserved.
//

import UIKit
import AFNetworking

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tweetsTableView: UITableView!

    var tweets: [Tweet]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tweetsTableView.dataSource = self
        self.tweetsTableView.delegate = self
        self.tweetsTableView.estimatedRowHeight = 200
        self.tweetsTableView.rowHeight = UITableViewAutomaticDimension
        
        TwitterClient.sharedInstance?.homeTimeline(success: { (tweets: [Tweet]) in
            self.tweets = tweets
            
            for tweet in tweets {
                print(tweet.text)
            }
            
            self.tweetsTableView.reloadData()
            
        }, failure: { (error: Error) in
            print(error.localizedDescription)
        })
                
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogoutButton(_ sender: AnyObject) {
        TwitterClient.sharedInstance?.logout()
    }
    
    @IBAction func onTweetButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nc = storyboard.instantiateViewController(withIdentifier: "ComposeNavigationController")
        let vc = nc.childViewControllers.first as! NewTweetViewController
        
        present(nc, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tweetsTableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        let currentTweet = tweets![indexPath.row]
        let currentUser = (currentTweet.creator)!
        cell.profileView.setImageWith(currentUser.profileURL!)
        cell.nameLabel.text = currentUser.name
        cell.screenNameLabel.text = currentUser.screenname
        cell.descriptionLabel.text = currentTweet.text
        cell.timeLabel.text = currentTweet.timeString
        cell.id = currentTweet.postID
        
        cell.tweet = currentTweet
        cell.delegate = self

        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tweets = tweets {
            return tweets.count
        } else {
            return 0;
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.

        let cell = sender as! TweetCell
        let indexPath = self.tweetsTableView.indexPath(for: cell)
        let currentTweet = tweets?[(indexPath?.row)!]
        
        let destinationViewController = segue.destination as! DetailsViewController
        destinationViewController.thisTweet = currentTweet!        
    }
}

extension TweetsViewController: TweetTableViewCellDelegate {
    func profileImageViewTapped(cell: TweetCell, user: User) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let profileVC = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController {
            profileVC.user = user
            self.navigationController?.pushViewController(profileVC, animated: true)
        }
    }
}
