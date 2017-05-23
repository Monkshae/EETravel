//
//  EEMainTabBarViewModel.swift
//  EEETravel
//
//  Created by licong on 2017/3/29.
//  Copyright © 2017年 Richard. All rights reserved.
//

import UIKit
import Then
import SwiftIcons

class EEMainTabBarViewModel: NSObject {
    
    var tabClassArray: [UIViewController.Type] = [EEHomeController.self,
                                             EETravelController.self,
                                             EEFrequentFlyerController.self,
                                             EEDiscountController.self]
    private var tabNameArray = ["首页", "旅游", "常旅客", "折扣"]
    private var tabNomalIconArray = [FontType.icofont(.home), FontType.icofont(.uiTravel), FontType.icofont(.travelling), FontType.icofont(.saleDiscount)]
//    private var tabPressIconArray: [String] = []
    
    override init() {
       super.init()
//        generatePressIcon()
    }
    
//    func generatePressIcon() {
//        for i in 0 ..< tabNomalIconArray.count  {
//            tabPressIconArray[i] = tabNomalIconArray[i] + "_" + String(i) + "_pr"
//        }
//    }
    
    func tabName(at index: Int) -> String {
        return tabNameArray[index]
    }
    
//    func tabNormalIcon(at index: Int) -> UIImage {
//        let image = UIImage(named: tabNomalIconArray[index])!
//        return image.withRenderingMode(.alwaysOriginal)
//    }
    
    func tabNormalIcon(at index: Int) -> FontType {
        return tabNomalIconArray[index]
    }
    
//    func tabPressIcon(at index: Int) -> UIImage {
//        let image = UIImage(named: tabPressIconArray[index])!
//        return image.withRenderingMode(.alwaysOriginal)
//    }
    
}

