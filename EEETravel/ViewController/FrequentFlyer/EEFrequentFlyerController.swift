//
//  EEFrequentFlyerViewController.swift
//  EEETravel
//
//  Created by licong on 2017/3/25.
//  Copyright © 2017年 Richard. All rights reserved.
//

import UIKit

class EEFrequentFlyerController: EEBaseController, ListProtocol {
    var viewModel = EEFrequentFlyerViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        addTableView(style: .plain, fetchNow: true)
        tableView.snp.updateConstraints { (make) in
            make.bottom.equalTo(-49)
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cellType: EEHomeCell.self)
    }
}

extension EEFrequentFlyerController: UITableViewDelegate, UITableViewDataSource {
    
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
        
    }
    
    func configData(for cell: EEHomeCell, at indexPath: IndexPath) {
        cell.titleLabel.text = viewModel.title(at: indexPath)
        cell.nameLabel.text = viewModel.name(at: indexPath)
        cell.timeLabel.text = viewModel.interval(at: indexPath)
        cell.icon.kf.setImage(with: URL(string:viewModel.icon(at: indexPath)), placeholder: nil, options: [.transition(.fade(1))], progressBlock: nil, completionHandler: nil)
    }
    
}
