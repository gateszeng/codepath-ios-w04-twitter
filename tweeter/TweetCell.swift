//
//  TweetCell.swift
//  tweeter
//
//  Created by Gates Zeng on 3/4/17.
//  Copyright © 2017 Gates Zeng. All rights reserved.
//

import UIKit

protocol TweetTableViewCellDelegate: class {
    func profileImageViewTapped(cell: TweetCell, user: User)
}

class TweetCell: UITableViewCell {
    @IBOutlet weak var profileView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    
    
    weak var delegate: TweetTableViewCellDelegate?
    var tweet: Tweet!
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
    
    @IBOutlet weak var userImageView: UIImageView! {
        didSet {
            self.userImageView.isUserInteractionEnabled = true
            let userProfileTap = UITapGestureRecognizer(target: self, action: #selector(userProfileTapped(_:)))
            self.userImageView.addGestureRecognizer(userProfileTap)
        }
    }
    
    func userProfileTapped(_ gesture: UITapGestureRecognizer) {
        if let delegate = delegate {
            delegate.profileImageViewTapped(cell: self, user: self.tweet.creator!)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func userTappedProfileImage(sender: UITapGestureRecognizer) {
        if let imageView = sender.view as? UIImageView {
            let cell = imageView.superview?.superview as? TweetCell
            
        }
    }
}
