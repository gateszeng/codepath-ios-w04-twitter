//
//  ReplyViewController.swift
//  tweeter
//
//  Created by Gates Zeng on 3/6/17.
//  Copyright © 2017 Gates Zeng. All rights reserved.
//

import UIKit

class ReplyViewController: UIViewController {
    @IBOutlet weak var profileView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var replyField: UITextField!
    
    var tweet: Tweet!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileView.setImageWith((tweet.creator?.profileURL)!)
        nameLabel.text = tweet.creator?.name
        screenNameLabel.text = tweet.creator?.screenname
        replyField.text = "@\(tweet.creator!.screenname!) "

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onPostButton(_ sender: Any) {
        TwitterClient.sharedInstance?.postNewReply(tweetString: replyField.text!, id: tweet.postID!)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onCancelButton(_ sender: Any) {
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
