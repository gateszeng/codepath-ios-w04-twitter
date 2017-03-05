//
//  TweetCell.swift
//  tweeter
//
//  Created by Gates Zeng on 3/4/17.
//  Copyright © 2017 Gates Zeng. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    @IBOutlet weak var profileView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    
    var id: String?
    
    @IBAction func retweetButtonClicked(_ sender: AnyObject) {
        retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon-green"), for: .normal)
        TwitterClient.sharedInstance?.sendRetweet(id: id!)
    }
    
    @IBAction func favoriteButtonClicked(_ sender: AnyObject) {
        favoriteButton.setImage(#imageLiteral(resourceName: "favor-icon-red"), for: .normal)
        TwitterClient.sharedInstance?.sendFavorite(id: id!)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
