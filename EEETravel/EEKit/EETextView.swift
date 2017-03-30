//
//  ETextView.swift
//  EEETravel
//
//  Created by licong on 2016/11/23.
//  Copyright © 2016年 Richard. All rights reserved.
//

import UIKit

class EETextView: UITextView {

    public var placeholder: String? {
        didSet {
            setNeedsDisplay()
        }
    }
    public var placeholderColor: UIColor? {
        didSet {
            setNeedsDisplay()
        }
    }

    override var text: String! {
        didSet {
            setNeedsDisplay()
        }
    }

    override var font: UIFont? {
        didSet {
            setNeedsDisplay()
        }
    }

    override var attributedText: NSAttributedString! {
        didSet {
            setNeedsDisplay()
        }
    }

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {
        font = EEFont(size: 15)
        placeholderColor = UIColor.gray
        NotificationCenter.default.addObserver(self, selector: #selector(EETextView.textDidChange), name: NSNotification.Name.UITextViewTextDidChange, object: nil)
    }

    func textDidChange(noti: NSNotification) {
        //会重新调用drawRcet
        setNeedsDisplay()
    }

    override func draw(_ rect: CGRect) {

        guard placeholder != nil else { return }
        //如果有文字，就直接返回，不需要画占位文字
        if hasText { return }
        //属性
        var attrs =  [String: AnyObject]()
        attrs[NSFontAttributeName] = font
        attrs[NSForegroundColorAttributeName] = placeholderColor
        //画文字
        var newRect = rect
        newRect.origin.x = 5
        newRect.origin.y = 8
        newRect.size.width -= 2 * rect.origin.x
        placeholder!.draw(in: newRect, withAttributes: attrs)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setNeedsDisplay()
    }
}
