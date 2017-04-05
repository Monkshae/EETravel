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
    var title = EELabel(.left, UIColor.black, 18)
    var timeLabel = EELabel(.right, UIColor.black, 12)
    var nameLabel = EELabel(.left, UIColor.black, 12)
    
    override func setup() {
        super.setup()
        contentView.addSubview(icon)
        icon.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.equalTo(8)
            make.bottom.equalTo(-8)
            make.size.equalTo(CGSize(width: 50, height: 50))
        }
        contentView.addSubview(title)
        title.snp.makeConstraints { (make) in
            make.left.equalTo(icon.right).offset(8)
            make.top.equalTo(icon.top).offset(5)
            make.right.equalTo(-15)
        }
        
        contentView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { (make) in
            make.right.equalTo(icon.right).offset(-15)
            make.bottom.equalTo(icon.top).offset(-5)
        }
    
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(icon.right).offset(8)
            make.bottom.equalTo(icon.top).offset(-5)
        }
        
    }

}
