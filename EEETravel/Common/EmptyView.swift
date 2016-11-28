//
//  EmptyView.swift
//  GengmeiDoctor
//
//  Created by Thierry on 16/4/21.
//  Copyright © 2016年 wanmeizhensuo. All rights reserved.
//

import UIKit
//import GMKit
import SnapKit

protocol EmptyViewDelegate: class {
    /**
     重新加载按钮点击
     */
    func emptyViewDidClickReload()
}

/**
 空页面的类型枚举

 - Empty:     空页面
 - Exception: 异常页面
 */
enum EmptyViewType {
    case Empty, Exception
}

/// 列表数据为空或异常时显示的View类
class EmptyView: GMView {

    let tipIcon: GMImageView = GMImageView()
    let tipLabel: GMLabel = GMLabel()
    let tipButton: GMButton = GMButton()

    var exceptionImage = "network_failed_icon"
    var exceptionText = "网络请求失败，请检查您的网络设置"

    var type = EmptyViewType.Empty
    var emptyImage = "empty_icon"
    var emptyText = ""

    weak var delegate: EmptyViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.backgroundColor()
        self.addSubview(tipIcon)
        tipLabel.numberOfLines = 2
        tipLabel.textColor = UIColor.secondaryTextColor()
        tipLabel.font = GMFont(14)
        tipLabel.textAlignment = NSTextAlignment.Center
        self.addSubview(tipLabel)

        tipButton.layer.borderColor = UIColor.disableColor().CGColor
        tipButton.layer.borderWidth = Constant.onePixel
        tipButton.hidden = true
        tipButton.setTitle("重新加载", forState: UIControlState.Normal)
        tipButton.titleLabel?.font = GMFont(14)
        tipButton.setTitleColor(UIColor.bodyTextColor(), forState: UIControlState.Normal)
        self.addSubview(tipButton)

        tipButton.addTarget(self, action: #selector(reloadBtnTap), forControlEvents: UIControlEvents.TouchUpInside)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        switch self.type {
        case .Empty:
            tipIcon.image = UIImage(named: emptyImage)
            tipLabel.text = emptyText
            tipButton.hidden = true
            tipIcon.snp_remakeConstraints { (make) in
                make.centerX.equalTo(self)
                make.centerY.equalTo(self).offset(-50)
                make.width.equalTo(140)
                make.height.equalTo(93)
            }
            tipLabel.snp_remakeConstraints { (make) in
                make.top.equalTo(tipIcon.snp_bottom).offset(25)
                make.height.equalTo(50)
                make.width.equalTo(280)
                make.centerX.equalTo(self)
            }
        case .Exception:
            tipIcon.image = UIImage(named: exceptionImage)
            tipLabel.text = exceptionText
            tipButton.hidden = false
            tipIcon.snp_remakeConstraints { (make) in
                make.centerX.equalTo(self)
                make.centerY.equalTo(self).offset(-50)
                make.width.equalTo(100)
                make.height.equalTo(81)
            }
            tipLabel.snp_remakeConstraints { (make) in
                make.height.equalTo(25)
                make.top.equalTo(tipIcon.snp_bottom).offset(15)
                make.centerX.equalTo(self)
            }
            tipButton.snp_remakeConstraints { (make) in
                make.top.equalTo(tipLabel.snp_bottom).offset(15)
                make.centerX.equalTo(self)
                make.width.equalTo(90)
                make.height.equalTo(30)
            }
        }
    }

    func reloadBtnTap() {
        delegate?.emptyViewDidClickReload()
    }
}
