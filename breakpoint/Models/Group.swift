//
//  Group.swift
//  breakpoint
//
//  Created by Hosam Elnabawy on 5/2/20.
//  Copyright © 2020 Hosam Elnabawy. All rights reserved.
//

import Foundation


class Group {
    private(set) var id: String
    private(set) var title: String
    private(set) var description: String
    private(set) var members: [String] = []
    
    var membersCount: Int {
        return members.count
    }
    init(id: String, title: String, description: String, members: [String]) {
        self.id = id
        self.title = title
        self.description = description
        self.members = members
    }
}
