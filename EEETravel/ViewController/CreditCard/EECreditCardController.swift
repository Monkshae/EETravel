//
//  EECreditCardController.swift
//  EEETravel
//
//  Created by licong on 2017/6/6.
//  Copyright © 2017年 Richard. All rights reserved.
//

import UIKit

class EECreditCardController: EEBaseController, ListProtocol {
    var viewModel = EECreditCardViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.title = "信用卡"
        addTableView(style: .plain, fetchNow: true)
        tableView.snp.updateConstraints { (make) in
            make.bottom.equalTo(-49)
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cellType: EEHomeCell.self)
    }
}

extension EECreditCardController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.fd_heightForCell(with: "EEHomeCell", cacheBy: indexPath) { (cell) in
            self.configData(for: cell as! EEHomeCell, at: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as EEHomeCell
        configData(for: cell, at: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let webComp = EEWebViewController()
        webComp.fullUrl = viewModel.url(at: indexPath)
        navigationController?.pushViewController(webComp, animated: true)
    }
    
    func configData(for cell: EEHomeCell, at indexPath: IndexPath) {
        cell.titleLabel.text = viewModel.title(at: indexPath)
        cell.nameLabel.text = viewModel.name(at: indexPath)
        cell.timeLabel.text = viewModel.interval(at: indexPath)
        cell.icon.kf.setImage(with: URL(string:viewModel.icon(at: indexPath)), placeholder: nil, options: [.transition(.fade(1))], progressBlock: nil, completionHandler: nil)
    }
    
}
