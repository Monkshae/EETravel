//
//  HomeController.swift
//  EEETravel
//
//  Created by licong on 2016/11/21.
//  Copyright © 2016年 Richard. All rights reserved.
//

import UIKit
import Alamofire
import EVReflection

class EEHomeController: EEBaseController, ListProtocol {
    
    var viewModel = EEHomeViewModel()
    
    override func initController() {
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadServiceFilter()
        
    }

    func downloadServiceFilter() {
        EEProvider.request(.home) { result in
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

