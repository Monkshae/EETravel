//
//  EETableViewCell.swift
//  EEETravel
//
//  Created by licong on 2017/4/5.
//  Copyright © 2017年 Richard. All rights reserved.
//

import UIKit
//import SnapKit
import Kingfisher

class EETableViewCell: UITableViewCell {

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public var detailDisclosure: UIImageView!
    
    /** @brief Cell统一下边框。不需要时需要隐藏 */
    public var bottomLine: UIView!
    
    /**
     *  @brief  代替 UITableViewCellAccessoryDetailDisclosureButton，默认 NO，不显示。控制的是 _detailDisclosure。
     */
    public var showArrow: Bool! {
        willSet {
            detailDisclosure.isHidden = newValue
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        lifeCycle()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        lifeCycle()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lifeCycle()
    }
    
    /**
     *  @brief  重写的起点。如果想在cell里添加息定义的view，或者改变bottomLine，从这里开始。
     *  必须调用super
     */
    public func setup() {
        contentView.bounds = UIScreen.main.bounds
        selectionStyle = .none
        accessoryType = .none
        
        bottomLine = addHorizontalLineWith(bottom: 0)
        bottomLine.backgroundColor = UIColor.backgroundColor()
        
        detailDisclosure = UIImageView(image: UIImage(named: "arrow"))
        detailDisclosure.isHidden = true
        contentView.addSubview(detailDisclosure)
        detailDisclosure.snp.makeConstraints { (make) in
            make.right.equalTo(-15)
            make.centerY.equalTo(contentView.centerY)
            make.size.equalTo(CGSize(width: 7, height: 11))
        }
        fd_usingFrameLayout = false
    }
    
    /*
     *  @brief  在 lifeCycle 里调用。里面为固定不变的约束
     */
    public func cellConstraints() {}
    
    /**
     *  @brief  在 lifeCycle 里调用。需要变化的约束写在这里
     */
    public func updateCellConstraints() {}
    
    private func lifeCycle() {
        setup()
        cellConstraints()
        updateCellConstraints()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        contentView.bounds = UIScreen.main.bounds
    }

    override var layoutMargins: UIEdgeInsets {
        set {
        }
        get {
            return .zero
        }
    }
    
}
