//
//  EView.swift
//  EEETravel
//
//  Created by licong on 2016/11/23.
//  Copyright © 2016年 Richard. All rights reserved.
//

import UIKit

class EEView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    func setup() {

    }

}


public extension UIView {
    public var left: CGFloat {
        set(newValue) {
            var rect = frame
            rect.origin.x = newValue
            frame = rect
        }
        get {
            return frame.origin.x
        }
    }
    
    public var top: CGFloat {
        set(newValue) {
            var rect = frame
            rect.origin.y = newValue
            frame = rect
        }
        get {
            return frame.origin.y
        }
    }
    
    public var right: CGFloat {
        set(newValue) {
            var rect = frame
            rect.origin.x = newValue - frame.width
            frame = rect
        }
        get {
            return frame.origin.x + frame.width
        }
    }
    
    public var bottom: CGFloat {
        set(newValue) {
            var rect = frame
            rect.origin.y = newValue - frame.height
            frame = rect
        }
        get {
            return frame.origin.y + frame.height
        }
    }
    
    public var centerX: CGFloat {
        set(newValue) {
            center = CGPoint(x: newValue, y: center.y)
        }
        get {
            return center.x
        }
    }
    
    public var centerY: CGFloat {
        set(newValue) {
            center = CGPoint(x: center.x, y: newValue)
        }
        get {
            return center.y
        }
    }
    
    public var width: CGFloat {
        set(newValue) {
            var rect = frame
            rect.size.width = newValue
            frame = rect
        }
        get {
            return frame.width
        }
    }
    
    public var height: CGFloat {
        set(newValue) {
            var rect = frame
            rect.size.height = newValue
            frame = rect
        }
        get {
            return frame.height
        }
    }
    
    
}
