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
    
    //找到指定的view到根view的路径代码
    static func superView(view: UIView?) -> [UIView]? {
        //注意这里是copy了一份新的view只不过用了同一个变量名覆盖了
        var view = view
        guard view != nil else {
            return nil
        }
        var result = [UIView]()
        while view != nil {
            result.append(view!)
            view = view?.superview
        }
        return result
    }
    
}

// MARK -- LineWithAutoLayout
public extension UIView {
    
    public func createLine() -> UIView {
        let line = UIView()
        line.backgroundColor = UIColor.separatorLine
        addSubview(line)
        return line
    }
    
    public func addHorizontalLine(top: CGFloat, left: CGFloat = 0, right: CGFloat = 0) -> UIView {
        let line = createLine()
        line.snp.makeConstraints { (make) in
            make.top.equalTo(top)
            make.left.equalTo(left)
            make.right.equalTo(right)
            make.height.equalTo(Constant.onePixel)
        }
        return line
    }
    
    public func addHorizontalLineWith(bottom: CGFloat, left: CGFloat = 0, right: CGFloat = 0) -> UIView {
        let line = createLine()
        line.snp.makeConstraints { (make) in
            make.bottom.equalTo(bottom)
            make.left.equalTo(left)
            make.right.equalTo(right)
            make.height.equalTo(Constant.onePixel)
        }
        return line
    }
    
    public func addVerticalLineWith(left: CGFloat, top: CGFloat = 0, bottom: CGFloat = 0) -> UIView {
        let line = createLine()
        line.snp.makeConstraints { (make) in
            make.top.equalTo(top)
            make.left.equalTo(left)
            make.bottom.equalTo(bottom)
            make.width.equalTo(Constant.onePixel)
        }
        return line
    }
    
    public func addVerticalLine(right: CGFloat, top: CGFloat = 0, bottom: CGFloat = 0) -> UIView {
        let line = createLine()
        line.snp.makeConstraints { (make) in
            make.top.equalTo(top)
            make.right.equalTo(right)
            make.bottom.equalTo(bottom)
            make.width.equalTo(Constant.onePixel)
        }
        return line
    }
    
    public func addHorizontalCenterLineWith(left: CGFloat, right: CGFloat = 0) -> UIView {
        let line = createLine()
        line.snp.makeConstraints { (make) in
            make.centerY.equalTo(centerY)
            make.left.equalTo(left)
            make.right.equalTo(right)
            make.height.equalTo(Constant.onePixel)
        }
        return line
    }
    
    public func addVerticalCenterLineWith(top: CGFloat, bottom: CGFloat = 0) -> UIView {
        let line = createLine()
        line.snp.makeConstraints { (make) in
            make.centerX.equalTo(centerX)
            make.top.equalTo(left)
            make.bottom.equalTo(right)
            make.width.equalTo(Constant.onePixel)
        }
        return line
    }
}
