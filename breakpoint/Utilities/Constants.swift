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
    case GroupVC = "GroupVC"
}

enum Segues: String {
    case TabBar = "tabBarSegue"
    case GroupVCSegue = "GroupVCSegue"
}


let NotificationOnUserSelect = NSNotification.Name("onUserSelect")
