//
//  EENavigationMenu.swift
//  EEETravel
//
//  Created by licong on 2017/2/3.
//  Copyright © 2017年 Richard. All rights reserved.
//

import UIKit

fileprivate class EENavigationMenuPageControl: UIPageControl {
    override init(frame: CGRect) {
        super.init(frame: frame)
        pageIndicatorTintColor =  UIColor.separatorLineColor()
        currentPageIndicatorTintColor = UIColor.secondaryTextColor()
        hidesForSinglePage = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}


class EENavigationMenu: UICollectionView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
