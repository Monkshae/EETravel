//
//  EEHomeObject.swift
//  EEETravel
//
//  Created by licong on 2017/4/5.
//  Copyright © 2017年 Richard. All rights reserved.
//

import UIKit

class EEHomeBaseObject: BaseObject {
    var icon = ""
    var title = ""
    var pageView = ""
    var name = "麦迪文"
    var url = ""
    var content = ""
    var commentCount = ""
    var interval = ""
}

class EEHomeObject: BaseObject {
    var data: EEHomeBaseObject?
    var message = ""
    var error = 0
}
