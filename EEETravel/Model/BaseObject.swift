//
//  BaseObject.swift
//  GengmeiDoctor
//
//  Created by licong on 16/4/21.
//  Copyright © 2016年 wanmeizhensuo. All rights reserved.
//

import Foundation
import EVReflection

class BaseObject: EVObject {
    
    /**
     Override super setValue method, ignore warning
     
     - parameter value:
     - parameter key:
     */
    override func setValue(_ value: Any!, forUndefinedKey key: String) {}
    
    override func propertyMapping() -> [(keyInObject: String?, keyInResource: String?)] {
        return [("desc", "description")]
    }
}
