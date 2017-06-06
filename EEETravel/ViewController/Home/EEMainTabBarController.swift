//
//  EEMainTabBarController.swift
//  traval
//
//  Created by licong on 2016/10/31.
//  Copyright © 2016年 Monk. All rights reserved.
//

import UIKit
import SwiftIcons

class EEMainTabBarController: UITabBarController {

    var viewModel = EEMainTabBarViewModel()
    var controllers: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customTabBar()
        setupViewControllers()
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
//        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.gray, NSFontAttributeName: UIFont.systemFont(ofSize: 11)], for:.normal)
    }
    
    func setupViewControllers() {
        
        for i in 0 ..< viewModel.tabClassArray.count {
            let item = UITabBarItem(title: viewModel.tabName(at: i), image: nil, selectedImage: nil)
            item.setIcon(icon: viewModel.tabNormalIcon(at: i), size: CGSize(width: 35, height: 35), textColor: .black, backgroundColor: .clear, selectedTextColor: .mainVisual, selectedBackgroundColor: .clear)
            item.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.gray, NSFontAttributeName: EEFont(size: 11)], for: .normal)
            item.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.mainVisual, NSFontAttributeName: EEFont(size: 11)], for: .selected)
            let controllerClass = viewModel.tabClassArray[i]
            let controller  = controllerClass.init()
            controller.title = viewModel.tabName(at: i)
            controller.tabBarItem = item
            let navigationController = UINavigationController(rootViewController: controller)
            controllers.append(navigationController)
        }
        setViewControllers(controllers, animated: false)
    }
}
