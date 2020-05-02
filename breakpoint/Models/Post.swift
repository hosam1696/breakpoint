//
//  Post.swift
//  breakpoint
//
//  Created by Hosam Elnabawy on 5/1/20.
//  Copyright © 2020 Hosam Elnabawy. All rights reserved.
//

import Foundation


class Post {
    
    private var _content: String
    private var _senderId: String
    private var _createdAt: String
    
    var content: String {
        return _content
    }
    
    var senderId: String {
        return _senderId
    }
    
    var created_at: String {
        return _createdAt
    }
    
    init(content: String, senderId: String, createdAt: String) {
        self._content = content
        self._senderId = senderId
        self._createdAt = createdAt
    }
    
}
