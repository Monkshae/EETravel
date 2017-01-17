//
//  EECreditCardController.swift
//  EEETravel
//
//  Created by licong on 2017/1/3.
//  Copyright © 2017年 Richard. All rights reserved.
//

import UIKit
import Moya


class EECreditCardController: UIViewController {

    var emitterView = WaveEmitterView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.gray
        let btn = UIButton(type: .custom)
        btn.backgroundColor = UIColor(hex: 0x000000, alpha: 0.5)
        btn.frame = CGRect.init(x: Constant.screenWidth - 15 - 40, y: Constant.screenHeight - 100, width: 40, height: 40)
        btn.layer.cornerRadius = 20
        btn.addTarget(self, action: #selector(EECreditCardController.upvote), for: .touchUpInside)
        self.view .addSubview(btn)
        
        emitterView.frame = CGRect.init(x: 0, y: 0, width: 80, height: 400)
        emitterView.center = CGPoint.init(x: btn.center.x, y: btn.center.y - 200)
        self.view.addSubview(emitterView)
    }

    func upvote() {
        self.emitterView.emitImage(UIImage(named:"0")!)
    }
    
    
    func downloadServiceFilter() {
        EEProvider.request(.ServiceFilter) { result in
                var message = "Couldn't access API"
                if case let .success(response) = result {
                    let jsonString = try? response.mapString()
                    message = jsonString ?? message
                }
                self.showAlert("Zen", message: message)
        }
    }

    
    fileprivate func showAlert(_ title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(ok)
        present(alertController, animated: true, completion: nil)
    }
}
