//
//  FeedsPostTableViewCell.swift
//  breakpoint
//
//  Created by Hosam Elnabawy on 5/1/20.
//  Copyright © 2020 Hosam Elnabawy. All rights reserved.
//

import UIKit

class FeedsPostTableViewCell: UITableViewCell {

    private let dataService = DataService.instance
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var postContent: UILabel!
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupData(post: Post) {
        postContent.text = post.content
        dataService.getUserEmail(ofUid: post.senderId) { (email) in
            if email != nil {
                self.userEmail.text = email
            }
        }
        
    }
    
}
