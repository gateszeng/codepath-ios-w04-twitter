//
//  DetailsViewController.swift
//  tweeter
//
//  Created by Gates Zeng on 3/6/17.
//  Copyright © 2017 Gates Zeng. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    var thisTweet: Tweet!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImageView.setImageWith((thisTweet.creator?.profileURL)!)
        screenNameLabel.text = thisTweet.creator?.screenname
        nameLabel.text = thisTweet.creator?.name
        descriptionLabel.text = thisTweet.text

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onRetweetButton(_ sender: Any) {
    }

    @IBAction func onFavoriteButton(_ sender: Any) {
    }
    
    @IBAction func onReplyButton(_ sender: Any) {
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
