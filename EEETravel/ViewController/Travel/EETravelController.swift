//
//  EETravelViewController.swift
//  EEETravel
//
//  Created by licong on 2017/3/25.
//  Copyright © 2017年 Richard. All rights reserved.
//

import UIKit
import MonkeyKing

class EETravelController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let shareButton = EEButton(type: .custom)
        view.addSubview(shareButton)
        shareButton.addTarget(self, action: #selector(shareButtonClicked(button: )), for: .touchUpInside)
        shareButton.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 100, height: 35))
        }
        shareButton.setTitle("分享", for: .normal)
        shareButton.backgroundColor = UIColor.red
    }
    
    @objc func shareButtonClicked(button: EEButton) {
     
        let message = MonkeyKing.Message.weChat(.session(info: (
            title: "Session",
            description: "Hello Session",
            thumbnail: UIImage(named: "rabbit"),
            media: .url(URL(string: "http://www.apple.com/cn")!)
        )))
        
        MonkeyKing.deliver(message) { success in
            print("shareURLToWeChatSession success: \(success)")
        }
        
    }
}
