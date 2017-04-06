//
//  GMShareProtocol.swift
//  GMDoctor
//  Created by Thierry on 16/6/28.
//  Copyright © 2016年 Gengmei. All rights reserved.
import Foundation
import UIKit
//import GMPhobos
//import GMNetworking

protocol GMShareComponent: class/*, GMShareViewDelegate*/ {
    
    /**
     向页面添加SHARE组件
     in 2.3.0
     */
//    func showShareArea()
    
//    func willShowShare(_ shareView: GMShareView!)
    
    /**
     以下的两个方法由于涉及到，Objc调用Swift的Extension（带Where条件，无法映射成Objc方法）
     所以写了两个doXXX方法来封装，以下两个需要在业务层再实现一次
     如果未来ShareView用Swift重写一次，则可避免这种情况
     in 2.8.0
     */
//    func fetchSharePublishContent(_ shareType: GMShareType) -> NSMutableDictionary
//    func copyShareUrl()
}

private var shareViewAssociationKey: UInt8 = 10
private var shareObjectAssociationKey: UInt8 = 0

extension GMShareComponent where Self: EEBaseController {
    
//    var shareView: GMShareView {
//        get {
//            return objc_getAssociatedObject(self, &shareViewAssociationKey) as! GMShareView
//        }
//        set(newValue) {
//            objc_setAssociatedObject(self, &shareViewAssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
//        }
//    }
//    
//    var shareObject: GMShareObject {
//        get {
//            return objc_getAssociatedObject(self, &shareObjectAssociationKey) as! GMShareObject
//        }
//        set(newValue) {
//            objc_setAssociatedObject(self, &shareObjectAssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
//        }
//    }
//    
//    func initShareComponent(_ title: String = "分享至") {
//        shareView = (Bundle.main.loadNibNamed(String(describing: GMShareView.self), owner: nil, options: nil)!.first as? GMShareView)!
//        shareView.delegate = self
//        if title.isNonEmpty() {
//            shareView.shareTitle = title
//        }
//    }
//
//    //TODO
//    func willShowShareView(shareView: GMShareView!) {
//        shareView.showRefresh = false
//        shareView.showCopyLink = false
//    }
//    
//    func handleGlobalDataForShare(_ data: [String: AnyObject]!) {
//        shareView.showFavor = data["is_favord"] as? Bool ?? false
//        shareView.showDelete = data["is_private"] as? Bool ?? false
//        navigationBar.rightButton.isHidden = data["hide_share"] as? Bool ?? false
//    }
//    
//    func doFetchSharePublishContent(_ shareType: GMShareType) -> NSMutableDictionary {
//        var channel = ""
//        let type =  shareOrFavType.isNonEmpty() ? shareOrFavType : "common_webview"
//        let from =  shareOrFavType.isNonEmpty() ? shareOrFavType : "common_webview"
//        var shareBaseobj = GMShareBasicObject()
//        var shareTitle = ""
//        var shareImage: UIImage
//        if !shareObject.image.isNonEmpty() {
//            shareImage = UIImage(named: "icon")!
//        } else {
//            shareImage = ShareSDK.compress(withUrl: shareObject.image)
//        }
//        
//        switch shareType {
//        case .wechatSession:
//            shareBaseobj = shareObject.wechat
//            channel = "wechat"
//            shareTitle = shareObject.wechat.title
//            break
//        case .wechatTimeline:
//            shareBaseobj = shareObject.wechatline
//            channel = "wechatline"
//            shareTitle = shareObject.wechatline.title
//            break
//        case .qqFriend:
//            shareBaseobj = shareObject.qq
//            channel = "QQ"
//            shareTitle = shareObject.qq.title
//            break
//        case .qqSpace:
//            shareBaseobj = shareObject.qq
//            channel = "qzone"
//            shareTitle = shareObject.qq.title
//            break
//        case .sinaWeibo:
//            shareBaseobj = shareObject.weibo
//            channel = "tsina"
//            shareTitle = shareObject.weibo.title
//            break
//        default:
//            break
//        }
//        
//        let dic: JsonType = ["type": type as AnyObject, "share_channel": channel as AnyObject, "from": from as AnyObject, "business_id": self.businessId as AnyObject]
//        Phobos.track("page_click_share_channel", attributes:dic)
//        let shareParams = NSMutableDictionary()
//        shareParams.ssdkSetupShareParams(byText: shareBaseobj.content, images: shareImage, url: URL(string: shareObject.url), title: shareTitle, type: .auto)
//        return shareParams
//
//    }
//    
//    func doCopyShareUrl() {
//        let pasteboard = UIPasteboard.general
//        if shareObject.url.isNonEmpty() {
//            pasteboard.string = shareObject.url
//            toast("链接已复制到系统粘帖板")
//        }
//    }
    
}

