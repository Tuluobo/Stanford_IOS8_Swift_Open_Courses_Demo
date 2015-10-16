//
//  TweetTableViewCell.swift
//  Smashtag
//
//  Created by WangHao on 15/10/16.
//  Copyright © 2015年 Tuluobo. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

    @IBOutlet weak var tweetProfileImageView: UIImageView!
    @IBOutlet weak var tweetScreenNameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var tweetUpdateTime: UILabel!
    
    var tweet: Tweet? {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
    
        //重置UI的信息
        tweetTextLabel.attributedText = nil
        tweetScreenNameLabel.text = nil
        tweetProfileImageView.image = nil
        tweetUpdateTime.text = nil
        // 下载新的tweet信息
        if let tweet = self.tweet {
            tweetTextLabel?.text = tweet.text
            if tweetTextLabel?.text != nil {
                for _ in tweet.media {
                    tweetTextLabel.text! += " 📷"
                }
            }
            
            tweetScreenNameLabel?.text = "\(tweet.user)"
            
            if let profileImageURL = tweet.user.profileImageURL {
                let qos = Int(QOS_CLASS_USER_INITIATED.rawValue)
                dispatch_async(dispatch_get_global_queue(qos, 0), { () -> Void in
                    let imageData = NSData(contentsOfURL: profileImageURL)
                    dispatch_sync(dispatch_get_main_queue()){
                        if profileImageURL == self.tweet?.user.profileImageURL {
                            if imageData != nil {
                                self.tweetProfileImageView?.image = UIImage(data: imageData!)
                            }
                        }
                    }
                })
            }
            let formatter = NSDateFormatter()
            if NSDate().timeIntervalSinceDate(tweet.created) > 24*60*60 {
                formatter.dateStyle = NSDateFormatterStyle.ShortStyle
            }else{
                formatter.dateStyle = NSDateFormatterStyle.LongStyle
            }
            tweetUpdateTime?.text = formatter.stringFromDate(tweet.created)
        }
        
    }
}
