//
//  Group.swift
//  breakpoint
//
//  Created by Hosam Elnabawy on 5/2/20.
//  Copyright © 2020 Hosam Elnabawy. All rights reserved.
//

import Foundation


class Group {
    private(set) var title: String
    private(set) var description: String
    
    init(title: String, description: String) {
        self.title = title
        self.description = description
    }
}
