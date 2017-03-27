//
//  EEMainTabBarController.swift
//  traval
//
//  Created by licong on 2016/10/31.
//  Copyright © 2016年 Monk. All rights reserved.
//

import UIKit

class EMainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        customTabBar()
    }
    
    
    func customTabBar() {
        tabBar.backgroundColor = UIColor(patternImage: UIImage(named: "tab_background")!)
        //获得全局的tabBar
        let bar =  UITabBar.appearance()
        let item =  UITabBarItem.appearance()
        //让系统的背景图和阴影都变成透明的
        bar.backgroundImage = UIImage()
        bar.shadowImage = UIImage()
        //调整title在tabbar中的位置
        item.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 0)
        //全局设置title的font、color等
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.gray, NSFontAttributeName: UIFont.systemFont(ofSize: 11)], for:.normal)

    }
    
    
    
}
