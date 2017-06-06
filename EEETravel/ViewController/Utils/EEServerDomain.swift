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
    static let APIHost = "https://www.eee.com/"
    
    fileprivate init() {
        
    }
}
