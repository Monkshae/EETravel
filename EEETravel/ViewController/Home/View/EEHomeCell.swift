//
//  EEHomeCell.swift
//  EEETravel
//
//  Created by licong on 2017/4/5.
//  Copyright © 2017年 Richard. All rights reserved.
//

import UIKit
import Reusable

final class EEHomeCell: EETableViewCell, Reusable {

    var icon = EEImageView()
    var titleLabel = EELabel(.left, UIColor.black, 16)
    var timeLabel = EELabel(.right, UIColor.black, 12)
    var nameLabel = EELabel(.left, UIColor.black, 12)
    
    override func setup() {
        super.setup()
        contentView.addSubview(icon)
        icon.backgroundColor = UIColor.white
        icon.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.equalTo(8)
            make.bottom.equalTo(-8)
            make.size.equalTo(CGSize(width: 80, height: 80))
        }
        contentView.addSubview(titleLabel)
        titleLabel.text = "招商银行 暖春四月 花样好礼（账单分期达标享乐上包/净水壶/骑行箱）"
        titleLabel.numberOfLines = 2
        titleLabel.lineBreakMode = .byCharWrapping
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(icon.snp.right).offset(8)
            make.top.equalTo(icon.snp.top).offset(5)
            make.right.equalTo(-15)
        }
        
        contentView.addSubview(timeLabel)
        timeLabel.text = "4h前"
        timeLabel.snp.makeConstraints { (make) in
            make.right.equalTo(-15)
            make.bottom.equalTo(contentView.snp.bottom).offset(-5)
        }
    
        contentView.addSubview(nameLabel)
        nameLabel.text = "selina"
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(icon.snp.right).offset(8)
            make.bottom.equalTo(contentView.snp.bottom).offset(-5)
        }
        
    }

}
