//
//  GroupCell.swift
//  breakpoint
//
//  Created by Hosam Elnabawy on 5/2/20.
//  Copyright © 2020 Hosam Elnabawy. All rights reserved.
//

import UIKit

class GroupCell: UITableViewCell {

    @IBOutlet weak var groupTitle: UILabel!
    @IBOutlet weak var groupDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setupCell(group: Group) {
        self.groupTitle.text = group.title
        self.groupDescription.text = group.description
    }
    
}
