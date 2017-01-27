//
//  RoundedOutlinedButton.swift
//  touchid
//
//  Created by Kristina Dev on 1/27/17.
//  Copyright © 2017 Kristina Dev. All rights reserved.
//

import UIKit
@IBDesignable
class RoundedOutlinedButton: UIButton {
    @IBInspectable var cornerRadius: CGFloat = 0.0
        {
            didSet
            {
                setupView()
            }
        
        }
    @IBInspectable var borderWidth: CGFloat = 0.0
        {
            didSet
            {
                setupView()
            }
        }
    @IBInspectable var boarderColor: UIColor?
        {
            didSet
            {
                setupView()
            }
        
    }
    func setupView()
    {
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
        layer.borderColor = boarderColor?.cgColor
    
    }
    override func prepareForInterfaceBuilder() {
        setupView()
    }

}
