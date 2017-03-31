//
//  EEButton.swift
//  EEETravel
//
//  Created by licong on 2017/3/31.
//  Copyright © 2017年 Richard. All rights reserved.
//

import UIKit

class EEButton: UIButton {

    /**
     *  是否支持Button自适应热区,Apple人机交互指南建议，可点击控件的热区最好是44*44，默认是NO，不支持
     */
    var enableAdaptive = false
    /**
     *  自适应热区宽，默认是 44
     */
    var adaptiveHotAreaWidth: CGFloat = 44
    /**
     *  自适应热区高，默认是 44
     */
    var adaptiveHotAreaHeight: CGFloat = 44
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if !enableAdaptive {
            return super.point(inside: point, with: event)
        }
        //若原热区小于 _adaptiveHotAreaWidth x _adaptiveHotAreaHeight，则放大热区，否则保持原大小不变
        let widthDelta = max(adaptiveHotAreaWidth - bounds.width, CGFloat(0))
        let heightDelta = max(adaptiveHotAreaHeight - bounds.height, CGFloat(0))
        let alhpa = CGFloat(0.5)
        let newBounds = bounds.insetBy(dx: -alhpa * widthDelta, dy: -alhpa * heightDelta)
        return newBounds.contains(point)
    }

}
