//
//  EEWebEngine.swift
//  GMDoctor
//
//  Created by Thierry on 16/6/21.
//  Copyright © 2016年 Gengmei. All rights reserved.
//

import Foundation
import WebKit
//import GMUtil
import EVReflection

struct EEWebEngine {
    
    var cookies: [String] = []
    var webView: WKWebView?
    
    init() {
        syncCookies()
    }
    
    /**
     同步Cookie
     WKWebView不再和NSURLSession共享Cookie，所以需要手动同步
     */
    mutating func syncCookies() {
        for cookie in HTTPCookieStorage.shared.cookies(for: URL(string: EEServerDomain.sharedInstance.APIHost)!)! {
            let value = "\(cookie.name)=\(cookie.value)"
            cookies.append(value)
        }
    }
    
    /**
     构造Ajax Cookie的Script
     in 2.3.0
     
     - returns script
     */
    func ajaxCookie() -> String {
        var source = ""
        for cookie in HTTPCookieStorage.shared.cookies(for: URL(string: EEServerDomain.sharedInstance.APIHost)!)! {
            var string = "\(cookie.name)=\(cookie.value);domain=\(cookie.domain);path=\(cookie.path); expires=\(cookie.expiresDate)"
            if cookie.isSecure {
                string = "\(string);secure=true"
            }
            
            source.append("document.cookie='\(string)';")
        }
        return source
    }
    
    func webCookie() -> String {
        return cookies.joined(separator: ";")
    }
    
    /**
     解析全局JS对象
     */
    mutating func parseJSPageData(_ complete: @escaping ([String: AnyObject])->()) {
        webView?.evaluateJavaScript("window.GLOBAL.pagedata") { (object, error) in
            if let data = object as? [String: AnyObject] {
                complete(data)
            }
        }
    }
    
}
