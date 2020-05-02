//
//  Inset.swift
//  breakpoint
//
//  Created by Hosam Elnabawy on 4/30/20.
//  Copyright © 2020 Hosam Elnabawy. All rights reserved.
//

import UIKit



class InsetTextField: UITextField {

    
    var iconType: TextFieldType = .email
    
    @IBInspectable
    var labelType: String = "email" {
        didSet {
            if labelType == "email" {
                iconType = .email
            } else if labelType == "password" {
                iconType = .password
            } else {
                iconType = .email
            }
        }
    }
    
    private var padding: UIEdgeInsets = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func awakeFromNib() {
        setup()
    }
    
    func setup() {
        let placeholderAttr = NSAttributedString(string: self.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        self.attributedPlaceholder = placeholderAttr
        
        
        let iconView = UIView(frame: CGRect(x: 10, y: 10, width: 30, height: 30))
        
        iconView.backgroundColor = #colorLiteral(red: 0.1825974764, green: 0.2313164567, blue: 0.3251308693, alpha: 1)
        iconView.clipsToBounds = true
        iconView.layer.cornerRadius = 10
        print(iconType.rawValue)
        let imageView = UIImageView(image: UIImage(named: iconType.rawValue))
        imageView.frame = CGRect(x: 5, y: 8, width: 20, height: 14)
        
        iconView.addSubview(imageView)
        
        self.addSubview(iconView)
        
        
    }
}
