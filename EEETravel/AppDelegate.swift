//
//  AppDelegate.swift
//  EEETravel
//
//  Created by licong on 2016/11/21.
//  Copyright © 2016年 Richard. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.gray, NSFontAttributeName: UIFont.systemFont(ofSize: 11)], for:.normal)
        
        
        
        
        
        let controller = EHomeController()
        controller.title = "酒店"
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        let tabBarController = EMainTabBarController()
        
        let controller1 = EHomeController()
        controller1.tabBarItem.title = "航空"
        
        let controller2 = EHomeController()
        controller2.tabBarItem.title = "信用卡"
        
        
        let controller3 = EHomeController()
        controller3.tabBarItem.title = "综合"
        
        
        let controller4 = EHomeController()
        controller4.tabBarItem.title = "MORE"
        
        
        tabBarController.viewControllers = [controller,controller1,controller2,controller3,controller4]
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        return true
        
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

