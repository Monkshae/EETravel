//
//  GMAssociateObject.swift
//  Gengmei
//
//  Created by wangyang on 2017/1/13.
//  Copyright © 2017年 更美互动信息科技有限公司. All rights reserved.
//

import Foundation
func associatedObject<ValueType: AnyObject>(
    base: AnyObject,
    key: UnsafePointer<UInt8>,
    initialiser: () -> ValueType)
    -> ValueType {
        if let associated = objc_getAssociatedObject(base, key)
            as? ValueType { return associated }
        let associated = initialiser()
        objc_setAssociatedObject(base, key, associated,
                                 .OBJC_ASSOCIATION_RETAIN)
        return associated
}
func associateObject<ValueType: AnyObject>(
    base: AnyObject,
    key: UnsafePointer<UInt8>,
    value: ValueType) {
    objc_setAssociatedObject(base, key, value,
                             .OBJC_ASSOCIATION_RETAIN)
}

// 下面是demo
/*
class Miller {} // 这是我们要扩展的类
class Cat { // 每个磨坊主都有一只猫
    var name = "Puss"
}
private var catKey: UInt8 = 0 // 我们还是需要这样的模板
extension Miller {
    var cat: Cat { // cat「实际上」是一个存储属性
        get {
            return associatedObject(base: self, key: &catKey) { 
                return Cat() 
            } // 设置变量的初始值
        }
        set { associateObject(base: self, key: &catKey, value: newValue) }
    }
}

let grumpy = Miller()
grumpy.cat.name // 显示 Puss
grumpy.cat.name = "Hephaestos"
grumpy.cat.name // 显示 Hephaestos
 
 */
