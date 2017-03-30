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
        downloadServiceFilter()
    }
    
    func downloadServiceFilter() {
        EEProvider.request(.serviceFilter) { result in
                var message = "Couldn't access API"
                if case let .success(response) = result {
                    let jsonString = try? response.mapString()
                    _ = response.statusCode
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
