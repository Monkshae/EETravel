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
    override func viewDidLoad() {
        super.viewDidLoad()
//        downloadServiceFilter()
//        fetchData()
        addTableView(style: .plain, fetchNow: true)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        tableView.reloadData()
    }

    
    
//    func downloadServiceFilter() {
//        EEProvider.request(.home) { result in
//            var message = "Couldn't access API"
//            if case let .success(response) = result {
//                let jsonString = try? response.mapString()
//                _ = response.statusCode
//                message = jsonString ?? message
//            }
//            self.showAlert("Zen", message: message)
//        }
//    }
//    
//    fileprivate func showAlert(_ title: String, message: String) {
//        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
//        alertController.addAction(ok)
//        present(alertController, animated: true, completion: nil)
//    }
    
}

extension EEHomeController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = "哈哈哈"
        return cell!
    }
    
}

