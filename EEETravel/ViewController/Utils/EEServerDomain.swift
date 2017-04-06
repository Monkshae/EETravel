//
//  GM.swift
//  GMDoctor
//
//  Created by Terminator on 2017/1/17.
//  Copyright © 2017年 Gengmei. All rights reserved.
//

import UIKit


struct EEServerDomain {
    
    static var sharedInstance = EEServerDomain()
    fileprivate let userDefaults = UserDefaults.standard
    var APIHost = "https://doctor.gmei.com"
    
    fileprivate init() {
        
        #if APPSTORE
             APIHost = "https://doctor.gmei.com"
        #else
            let isHttps = userDefaults.object(forKey: "enabled_https") as? Bool ?? true
            
            if let serverDomain = userDefaults.object(forKey: "server_domain") as? String {
                if isHttps {
                    if serverDomain == "dev4" {
                        APIHost = String(format: "https://doctor.%@.gmei.com", serverDomain)
                    } else {
                        APIHost = String(format: "https://doctor-%@.gmei.com", serverDomain)
                    }
                } else {
                    APIHost = String(format: "http://doctor.%@.gmei.com", serverDomain)
                }
            } else {
                APIHost = "http://doctor.test.gmei.com"
            }
//             APIHost = "https://doctor.gmei.com"
        #endif
    }
}



