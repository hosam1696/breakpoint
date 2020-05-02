//
//  Constants.swift
//  breakpoint
//
//  Created by Hosam Elnabawy on 5/1/20.
//  Copyright © 2020 Hosam Elnabawy. All rights reserved.
//

import Foundation



enum TextFieldType: String {
    case email = "emailIcon"
    case password = "whiteCheckmark"
}


enum Identifiers: String {
    case SignupMethodVC = "SignupMethodVC"
    case FeedsPostTableViewCell = "FeedsPostTableViewCell"
    case UserCell = "UserCellTableViewCell"
    case GroupCell = "GroupCell"
}

enum Segues: String {
    case TabBar = "tabBarSegue"
}


let NotificationOnUserSelect = NSNotification.Name("onUserSelect")
