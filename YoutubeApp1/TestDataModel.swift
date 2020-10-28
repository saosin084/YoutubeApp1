//
//  TestDataModel.swift
//  YoutubeApp1
//
//  Created by yuta on 2020/09/13.
//  Copyright © 2020 yuta. All rights reserved.
//

import Foundation

class TestDataModel{
    
    var title:String
    var channel:String
    var count:Int
    var imageUrl:String
    
    internal init(title: String, channel: String, count: Int, imageUrl: String) {
        self.title = title
        self.channel = channel
        self.count = count
        self.imageUrl = imageUrl
    }
    
}
