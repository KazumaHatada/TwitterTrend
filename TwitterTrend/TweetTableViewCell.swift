//
//  TweetTableViewCell.swift
//  TwitterTrend
//
//  Created by Kazuma Hatada on 2019/08/27.
//  Copyright © 2019 Kazuma Hatada. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var contentsLabel: UILabel!
    
    func fill(tweet: Tweet) {
        print("hajimatta")
        // profileImageURLから画像をダウンロードしてくる処理
        let downloadTask = URLSession.shared.dataTask(with: URL(string: tweet.user.profileImageURL)!) { [weak self] data, response, error in
            if let error = error {
                print(error)
                return
            }
            
            DispatchQueue.main.async {
                // iconImageViewにダウンロードしてきた画像を代入する処理
                self?.iconImageView.image = UIImage(data: data!)
            }
        }
        downloadTask.resume()
        
        // tweetから値を取り出して、UIにセットする
        nameLabel.text = tweet.user.name
        contentsLabel.text = tweet.text
        // screenNameには "@" が含まれていないので、頭に "@" を入れてあげる必要がある
        screenNameLabel.text = "@" + tweet.user.screenName
        print("dekita")
    }
}
