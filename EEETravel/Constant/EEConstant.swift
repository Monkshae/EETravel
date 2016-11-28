//
//  Constant.swift
//  EEETravel
//
//  Created by licong on 2016/11/24.
//  Copyright © 2016年 Richard. All rights reserved.
//

import UIKit

import UIKit
import AdSupport

public struct Constant {

    //设备屏幕相关
    public static let screenFrame              = UIScreen.main.bounds
    public static let screenWidth              = UIScreen.main.bounds.size.width
    public static let screenHeight             = UIScreen.main.bounds.size.height
    public static let statusBarHeight          =  UIApplication.shared.statusBarFrame.size.height
    public static let deviceScale              = UIScreen.main.scale
    public static let onePixel                 = 1/Constant.deviceScale
    public static let systemVersion            = UIDevice.current.systemVersion
    public static let deviceModel              = UIDevice.current.model
    public static let IDFA                     = ASIdentifierManager.shared().advertisingIdentifier.uuidString

    public static let channelAppStore          = "AppStore"
    public static let platform                 = "iPhone"

    //沙盒目录
    public static let pathOfAppHome            = NSHomeDirectory()
    public static let pathOfTemp               = NSTemporaryDirectory()
    public static let pathOfBundle             = Bundle.main.resourcePath
    public static let pathOfDocument           = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]

    //获取NSUserdefault
    public static let userDefault              = UserDefaults.standard

    //App相关
    public static let appName                  = Bundle.main.infoDictionary!["CFBundleDisplayName"] as! String
    public static let appVersion               = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    public static let appBuildVersion          = Bundle.main.infoDictionary!["CFBundleVersion"] as! String

    // App参数
    public static let lastEnterBackgroundTime  = "last_enter_background_time"   //上次APP进入后台的时间
    public static let reinitAppTimeinterval    = 60*60*4                        //需要初始化App的时间
    public static let pageCount                = 10                             //分页每一页的数据数量
}


public func EEFont(size: Int) -> UIFont {
    return UIFont.swiftFontWithSize(CGFloat(size))
}

extension UIFont {
    static func swiftFontWithSize(_ size: CGFloat) -> UIFont {

//        let font = UIFont(name: "FZLTHThin--GB1-4-YS", size: size)
//        if font == nil {
//            if UIDevice.current.systemVersion.compare("9.0", options: NSString.CompareOptions.numeric) != .orderedAscending {
            return UIFont(name: "PingFangSC-Regular", size: size)!
//            } else {
//                return UIFont(name: "STHeitiSC-Light", size: size)!
//            }
//        }
//        return font!
    }

}
