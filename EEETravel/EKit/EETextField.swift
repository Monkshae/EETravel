//
//  ETextField.swift
//  EEETravel
//
//  Created by licong on 2016/11/23.
//  Copyright © 2016年 Richard. All rights reserved.
//

import UIKit

class EETextField: UITextField {

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return UIEdgeInsetsInsetRect(rect, UIEdgeInsetsMake(3, 8, 0, 8))
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
}
