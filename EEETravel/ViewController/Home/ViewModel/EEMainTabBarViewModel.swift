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
                                             EEDiscountController.self,
                                             EECreditCardController.self]
    private var tabNameArray = ["最新", "旅游", "常旅客", "购物", "信用卡"]
    private var tabNomalIconArray = [FontType.icofont(.home), FontType.icofont(.uiTravel), FontType.icofont(.travelling), FontType.icofont(.socialPrestashop), FontType.icofont(.creditCard)]
    
    override init() {
       super.init()
    }
    
    func tabName(at index: Int) -> String {
        return tabNameArray[index]
    }
    
    func tabNormalIcon(at index: Int) -> FontType {
        return tabNomalIconArray[index]
    }
}

