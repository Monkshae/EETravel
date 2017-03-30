//
//  Theme.swift
//  Pods
//
//  Created by licong on 16/7/25.
//
//

import UIKit

fileprivate struct Theme {

    //颜色规范
    static let mainVisualColor                  = 0x3ADBD2 //主视觉颜色
    static let secondaryVisualColor             = 0xFF7690 //辅助颜色
    static let mainTipColor                     = 0x9D704F //提示文字主色（黄背景）
    static let secondaryTipColor                = 0xC19474 //提示文字辅助色（黄背景）
    static let disableColor                     = 0xD5D5D5 //失效颜色
    static let separatorLineColor               = 0xE5E5E5 //分割线颜色、边框颜色
    static let backgroundColor                  = 0xF5F5F5 //背景颜色
    static let backgroundTipColor               = 0xF8F4DD //提示背景颜色(黄)
    static let blackColor                       = 0x000000 //纯黑颜色
    static let whiteColor                       = 0xFFFFFF //纯白颜色

    //文字颜色
    static let headlineTextColor                = 0x333333 //一级标题字、主要内容
    static let bodyTextColor                    = 0x666666 //正文、普通文字内容
    static let secondaryTextColor               = 0x999999 //辅助文字色

    //按钮颜色
    static let buttonNomarlGreenColor           = 0x3ADBD2
    static let buttonHighlightGreenColor        = 0x1FB2A7
    static let buttonNomarlRedColor             = 0xFF7690
    static let buttonHighlightRedColor          = 0xE75873
    static let buttonDisableColor               = 0xD5D5D5
}

public extension UIColor {
    //用于色值是数字
    convenience init(hex: Int) {
        let r = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((hex & 0x00FF00) >> 8) / 255.0
        let b = CGFloat((hex & 0x0000FF) >> 0) / 255.0
        self.init(red: r, green: g, blue: b, alpha: 1.0)
    }

    convenience init(hex: Int, alpha: Float) {
        let r = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((hex & 0x00FF00) >> 8) / 255.0
        let b = CGFloat((hex & 0x0000FF) >> 0) / 255.0
        self.init(red: r, green: g, blue: b, alpha: CGFloat(alpha))
    }
    //用于色值是字符串
    convenience init?(hexString: String) {
        var hex: UInt32 = 0
        let scanner = Scanner(string: hexString)
        if scanner.scanHexInt32(&hex) {
            self.init(hex: Int(hex))
        } else {
            self.init()
            return nil
        }
    }

    convenience init?(hexString: String, alpha: Float) {
        var hex: UInt32 = 0
        let scanner = Scanner(string: hexString)

        if scanner.scanHexInt32(&hex) {
            self.init(hex: Int(hex), alpha: alpha)
        } else {
            self.init()
            return nil
        }
    }

    /// 0x3ADBD2 主视觉颜色
    static func mainVisualColor() -> UIColor {
        return UIColor(hex: Theme.mainVisualColor)
    }

    /// 0xFF7690 辅助颜色
    static func secondaryVisualColor() -> UIColor {
        return UIColor(hex: Theme.secondaryVisualColor)
    }

    /// 0x9D704F 提示文字主色（黄背景）
    static func mainTipColor() -> UIColor {
        return UIColor(hex: Theme.mainTipColor)
    }

    /// 0xC19474 提示文字辅助色（黄背景）
    static func secondaryTipColor() -> UIColor {
        return UIColor(hex: Theme.secondaryTipColor)
    }

    /// 0xD5D5D5 失效颜色
    static func disableColor() -> UIColor {
        return UIColor(hex: Theme.disableColor)
    }

    /// 0xE5E5E5 分割线颜色、边框颜色
    static func separatorLineColor() -> UIColor {
        return UIColor(hex: Theme.separatorLineColor)
    }

    /// 0xF5F5F5 背景颜色
    static func backgroundColor() -> UIColor {
        return UIColor(hex: Theme.backgroundColor)
    }

    /// 0xF8F4DD 提示背景颜色(黄)
    static func backgroundTipColor() -> UIColor {
        return UIColor(hex: Theme.backgroundTipColor)
    }

    /// 0x333333 一级标题字、主要内容
    static func headlineTextColor() -> UIColor {
        return UIColor(hex: Theme.headlineTextColor)
    }

    /// 0x666666 正文、普通文字内容
    static func bodyTextColor() -> UIColor {
        return UIColor(hex: Theme.bodyTextColor)
    }

    /// 0x999999 辅助文字色
    static func secondaryTextColor() -> UIColor {
        return UIColor(hex: Theme.secondaryTextColor)
    }

    /// 0x3ADBD2
    static func buttonNomarlGreenColor() -> UIColor {
        return UIColor(hex: Theme.buttonNomarlGreenColor)
    }

    /// 0x1FB2A7
    static func buttonHighlightGreenColor() -> UIColor {
        return UIColor(hex: Theme.buttonHighlightGreenColor)
    }

    /// 0xFF7690
    static func buttonNomarlRedColor() -> UIColor {
        return UIColor(hex: Theme.buttonNomarlRedColor)
    }

    /// 0xE75873
    static func buttonHighlightRedColor() -> UIColor {
        return UIColor(hex: Theme.buttonHighlightRedColor)
    }

    /// 0xD5D5D5
    static func buttonDisableColor() -> UIColor {
        return UIColor(hex: Theme.buttonDisableColor)
    }
}
