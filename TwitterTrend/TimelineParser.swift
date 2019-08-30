//
//  TimelineParser.swift
//  TwitterTrend
//
//  Created by Kazuma Hatada on 2019/08/27.
//  Copyright © 2019 Kazuma Hatada. All rights reserved.
//

import Foundation

struct TimelineParser {
    func parse(data: Data) -> [Tweet] {
        let serializedData = try! JSONSerialization.jsonObject(with: data, options: .allowFragments)
        
        let json = serializedData as! [Any]
        
        let timeline: [Tweet] = json.compactMap {
            Tweet(json: $0)
        }
        
        return timeline
    }
}
