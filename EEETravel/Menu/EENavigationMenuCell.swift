//
//  EENavigationMenuCell.swift
//  EEETravel
//
//  Created by licong on 2017/2/4.
//  Copyright © 2017年 Richard. All rights reserved.
//

import UIKit
import SnapKit

class EENavigationMenuCell: UICollectionViewCell {
    open var imageView =  EEImageView()
    open var titleLabel = EELabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel = EELabel.label(.center, UIColor.clear, 11)
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        imageView = EEImageView(frame: CGRect(x: 0, y: 0, width: self.width, height: self.height))
        imageView.centerX = contentView.centerX
        contentView.addSubview(imageView)
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = imageView.width / 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
