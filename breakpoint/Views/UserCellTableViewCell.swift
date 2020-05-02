//
//  UserCellTableViewCell.swift
//  breakpoint
//
//  Created by Hosam Elnabawy on 5/1/20.
//  Copyright © 2020 Hosam Elnabawy. All rights reserved.
//

import UIKit

class UserCellTableViewCell: UITableViewCell {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var selectBtn: UIButton!
    var userIsSelected: Bool = false {
        didSet {
            if userIsSelected == true {
                selectBtn.backgroundColor = .green
            } else {
                selectBtn.backgroundColor = .systemFill
            }
            
            NotificationCenter.default.post(name: .OnUserSelect, object: self, userInfo: ["email": userEmail.text!, "operation": userIsSelected == true ? "append": "remove"])
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(email: String) {
        self.userEmail.text = email
    }
    @IBAction func onSelectUser(_ sender: Any) {
        userIsSelected = !userIsSelected
    }
    
}
