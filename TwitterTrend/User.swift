//
//  User.swift
//  TwitterTrend
//
//  Created by Kazuma Hatada on 2019/08/27.
//  Copyright © 2019 Kazuma Hatada. All rights reserved.
//

import Foundation

struct User {
    
    // ユーザーのid
    let id: String
    
    // (@)ktanaka117
    let screenName: String
    
    // ダンボー田中
    let name: String
    
    // プロフィール画像URL
    let profileImageURL: String
    
    init?(json: Any) {
        guard let dictionary = json as? [String: Any] else { return nil }
        
        guard let id = dictionary["id_str"] as? String else { return nil }
        guard let screenName = dictionary["screen_name"] as? String else { return nil }
        guard let name = dictionary["name"] as? String else { return nil }
        guard let profileImageURL = dictionary["profile_image_url_https"] as? String else { return nil }
        
        self.id = id
        self.screenName = screenName
        self.name = name
        self.profileImageURL = profileImageURL
    }
}
