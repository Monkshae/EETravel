//
//  EELabel.swift
//  EEETravel
//
//  Created by licong on 2016/11/23.
//  Copyright © 2016年 Richard. All rights reserved.
//

import UIKit

/*
  垂直方向顶部的对齐方式，分别为上部对齐、中间对齐、和下部对齐
*/

enum EELabelVerticalAlignment {
    case Top, Middle, Bottom
}

class EELabel: UILabel {

    /**
     *  @brief  垂直方向对齐。默认是 GMLabelVerticalAlignmentMiddle。因为有这个属性，所以需要重写 drawTextInRect
     */
    public var verticalAlignment: EELabelVerticalAlignment?
    /**
     *  @brief  文字与label边框的padding。因为有这个方法，所以重写了 intrinsicContentSize
     */
    public var paddingEdge =  UIEdgeInsets.zero

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
        fatalError("init(coder:) has not been implemented")
    }

    open func setup() {
        verticalAlignment = .Middle
    }

    static func label(_ textAlignment: NSTextAlignment, _ textColor: UIColor, _ fontSize: Int) -> EELabel {
        let label = EELabel()
        label.textAlignment = textAlignment
        label.textColor = textColor
        label.font = EEFont(size: fontSize)
        return label
    }

    override func drawText(in rect: CGRect) {

        // 先去除paddingEdge，剩下的rect就是用来放 string 的 rect。但注意：未必是正好能容纳下string的大小的rect
        let contentRect = UIEdgeInsetsInsetRect(rect, paddingEdge)
        // 在contentRect内，string所需要的text rect
        var textRect = self.textRect(forBounds: contentRect, limitedToNumberOfLines: numberOfLines)
        textRect.origin.x = 0
        textRect.origin.y = 0
        guard let _ = verticalAlignment else {
            return
        }
        switch verticalAlignment! {
        case .Top:
            textRect.origin.y = 0
            break
        case .Bottom:
            textRect.origin.y = rect.height - textRect.height
            break
        case .Middle:
            textRect.origin.y = (rect.height - textRect.height) / 2
            break
        }

        switch textAlignment {
        case .right:
            textRect.origin.x = rect.width - textRect.width
            break
        case .center:
            textRect.origin.x = (rect.width - textRect.width) / 2
            break
        case .left:
            textRect.origin.x = 0
            break
        default: break
        }
        super.drawText(in: textRect)
    }


    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        let width = size.width + paddingEdge.left + paddingEdge.right
        let height = size.height + paddingEdge.top + paddingEdge.bottom
        let newSize = CGSize.init(width: CGFloat(ceilf(Float(width))), height: CGFloat(ceilf(Float(height))))
        return newSize
    }

}
