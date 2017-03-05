//
//  Tweet.swift
//  tweeter
//
//  Created by Gates Zeng on 2/27/17.
//  Copyright © 2017 Gates Zeng. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    
    var text: String?
    var timestamp: NSDate?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    var creator: User?
    var timeString: String?
    var postID: String?
    
    init(dictionary: NSDictionary) {
        text = dictionary["text"] as? String
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favourite_count"] as? Int) ?? 0
        creator = User(dictionary: (dictionary["user"] as? NSDictionary)!)
        postID = dictionary["id_str"] as? String
        
        let timestampString = dictionary["created_at"] as? String
        
        if let timestampString = timestampString {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timestamp = formatter.date(from: timestampString) as NSDate?
        }
        
        let currentTime = NSDate()
        let diff = currentTime.timeIntervalSince(timestamp as! Date)
        
        if (diff/3600 > 1) {
            // hour
            timeString = "\(Int(ceil(diff/3600)))" + " h"
        } else if (diff/60 > 1) {
            // minute
            timeString = "\(Int(ceil(diff/60)))" + " m"
        } else {
            // seconds
            timeString = "\(Int(ceil(diff)))" + " s"
        }
        
        
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary)
            tweets.append(tweet)
        }
        
        return tweets
    }

}
