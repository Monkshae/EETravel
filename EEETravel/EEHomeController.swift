//
//  HomeController.swift
//  EEETravel
//
//  Created by licong on 2016/11/21.
//  Copyright © 2016年 Richard. All rights reserved.
//

import UIKit
import Alamofire
import BTNavigationDropdownMenu
import ObjectMapper



class EEHomeController: UIViewController {
    var menuView: BTNavigationDropdownMenu!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let menu = SYNavigationDropdownMenu(navigationController: navigationController)
        menu?.dataSource = self
        menu?.delegate = self
        self.navigationItem.titleView = menu
        
    }

    
    
}

extension EEHomeController: SYNavigationDropdownMenuDataSource, SYNavigationDropdownMenuDelegate {
    func titleArray(for navigationDropdownMenu: SYNavigationDropdownMenu!) -> [String]! {
        return ["Hello aaaa", "World bbbbb", "I am Sunnyyoung 😄", "This is really","Hello aaaa", "World bbbbb", "I am Sunnyyoung 😄", "This is really","Hello aaaa", "World bbbbb", "I am Sunnyyoung 😄", "This is really","Hello aaaa", "World bbbbb", "I am Sunnyyoung 😄", "This is really","Hello aaaa", "World bbbbb", "I am Sunnyyoung 😄", "This is really"]
    }
    
    func arrowImage(for navigationDropdownMenu: SYNavigationDropdownMenu!) -> UIImage! {
        return UIImage(named: "Arrow")
    }
    
    func arrowPadding(for navigationDropdownMenu: SYNavigationDropdownMenu!) -> CGFloat {
        return 8.0
    }
    
    func navigationDropdownMenu(_ navigationDropdownMenu: SYNavigationDropdownMenu!, didSelectTitleAt index: UInt) {
//        self.label.text = titleArray[index]
    }
}


extension EEHomeController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }



    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
