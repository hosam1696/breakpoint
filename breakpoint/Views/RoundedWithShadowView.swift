//
//  RoundedView.swift
//  breakpoint
//
//  Created by Hosam Elnabawy on 5/1/20.
//  Copyright © 2020 Hosam Elnabawy. All rights reserved.
//

import UIKit



class RoundedWithShadowView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    
    override func awakeFromNib() {
        layer.cornerRadius = 20
        
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.7
        self.layer.shadowColor = #colorLiteral(red: 0.04705882353, green: 0.1017016545, blue: 0.07600714571, alpha: 1)
    }

}
