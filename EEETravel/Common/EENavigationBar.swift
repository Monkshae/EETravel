//
//  WYNavigationBar.swift
//  Gengmei
//
//  Created by licong on 16/5/23.
//  Copyright © 2017年 Richard. All rights reserved.
//

import UIKit

/**
 导航栏button的图片枚举

 - None:          无
 - Share:         分享
 - NewDiary:      写新日记
 - Search:        搜索按钮，这个option的action已经在GMBaseController中已经实现了
 - More:          更多，具体方法没有实现，请在子类中实现
 - ShareCashback: 分享返现，具体方法没有实现，请在子类中实现
 - Cart:          购物车
 - DarkGrayNormal:  后退键，深灰色
 - White:           后退键，白色
 */
enum GMBarButtonImageType: String {
    case Share = "share"
    case Search = "search_green"
    case ShareCashback = "share_cashback"
    case Cart = "icon_cart"
    case CartBadge = "icon_cart_dot"
    case CustomService = "customer_service"
    case BackNormal = "back"
    case BackWhite = "backWhite"

    var image: UIImage {
        let image = UIImage(named: self.rawValue)
        assert(image != nil, "\(self).rawValue = \(self.rawValue) 不能对应到一个UIImage")
        return image!
    }
}

class EENavigationBar: EEView {

    let itemView = EEView(frame: CGRect(x: 0, y: 20, width: Constant.screenWidth, height: 44))
    let titleLabel = EELabel.label(.center, UIColor.black, 16)
    let leftButton = EENavigationButton(type: .custom)
    let rightButton = EENavigationButton(type: .custom)
    let nearRightButton = EENavigationButton(type: .custom)
    var titleView: UIView? {
        didSet {
            if let newView = titleView {
                if newView != oldValue {
                    oldValue?.removeFromSuperview()
                }
                itemView.insertSubview(newView, at: 0)
            } else {
                oldValue?.removeFromSuperview()
            }
        }
    }

    var title: String? {
        willSet {
            titleLabel.isHidden = (newValue == nil)
            titleLabel.text = newValue
        }
    }

    var leftIcon: String? {
        willSet {
            setImage(iconName: newValue, for: leftButton)
        }
    }

    var rightIcon: String? {
        willSet {
            setImage(iconName: newValue, for: rightButton)
        }
    }

    var leftTitle: String? {
        willSet {
            leftButton.isHidden = false
            leftButton.setTitle(newValue, for: .normal)
            leftButton.setImage(nil, for: .normal)
        }
    }

    var rightTitle: String? {
        willSet {
            rightButton.isHidden = false
            rightButton.setTitle(newValue, for: .normal)
        }
    }

    var nearRightIcon: String? {
        willSet {
            setImage(iconName: newValue, for: nearRightButton)
        }
    }

    var nearRightTitle: String? {
        willSet {
            nearRightButton.isHidden = false
            nearRightButton.setTitle(newValue, for: .normal)
        }
    }

    private func setImage(iconName: String?, for button: EENavigationButton) {
        if let icon = iconName, let image = UIImage(named: icon) {
            button.isHidden = false
            button.setImage(image, for: .normal)
        } else {
            button.isHidden = true
            assert(iconName != nil && (iconName?.characters.count)! > 0, "找不到\(String(describing: iconName))图片")
        }
    }

    weak var delegate: EENavigationBarProtocol?
    private var shadowView: UIView?
    override func setup() {
        super.setup()
        self.backgroundColor = UIColor.white
        titleLabel.isHidden = true
        leftIcon = GMBarButtonImageType.BackNormal.rawValue
        leftButton.enableAdaptive = true
        leftButton.adaptiveHotAreaWidth = 70
        leftButton.setTitleColor(UIColor.headlineText, for: .normal)
        leftButton.titleLabel?.font = EEFont(size: 14)
        leftButton.addTarget(self, action: #selector(leftAction(button:)), for: .touchUpInside)

        rightButton.addTarget(self, action: #selector(rightAction(button:)), for: .touchUpInside)
        rightButton.isHidden = true
        rightButton.setTitleColor(UIColor.headlineText, for: .normal)
        rightButton.titleLabel?.font = EEFont(size: 14)
        rightButton.enableAdaptive = true
        rightButton.adaptiveHotAreaWidth = 40

        nearRightButton.isHidden = true
        nearRightButton.addTarget(self, action: #selector(nearRightAction(button:)), for: .touchUpInside)
        nearRightButton.setTitleColor(UIColor.headlineText, for: .normal)
        nearRightButton.titleLabel?.font = EEFont(size: 14)
        nearRightButton.enableAdaptive = true
        nearRightButton.adaptiveHotAreaWidth = 40

        addSubview(itemView)
        itemView.addSubview(titleLabel)
        itemView.addSubview(leftButton)
        itemView.addSubview(rightButton)
        itemView.addSubview(nearRightButton)
        titleLabel.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets.zero)
        }
        
        leftButton.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(15)
            
        }
        rightButton.snp.makeConstraints { (make) in
            make.right.equalTo(-15)
            make.centerY.equalTo(leftButton.snp.centerY)
        }
        nearRightButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(leftButton.snp.centerY)
            make.right.equalTo(rightButton.snp.left).offset(-20)
            
        }

        showShadow(shadow: true)
    }

    func showShadow(shadow: Bool) {
        if shadow && shadowView == nil {
            shadowView = addHorizontalLineWith(bottom: 0)
        } else if !shadow && shadowView != nil {
            shadowView?.removeFromSuperview()
            shadowView = nil
        }
    }

    func hideAllItems() {
        titleLabel.isHidden = true
        leftButton.isHidden = true
        rightButton.isHidden = true
        nearRightButton.isHidden = true
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        titleView?.centerY = itemView.height/2
        titleView?.centerX = itemView.width/2
    }

    @objc fileprivate func leftAction(button: EENavigationButton) {
        delegate?.leftButtonTap(button)
    }

    @objc fileprivate func rightAction(button: EENavigationButton) {
        delegate?.rightButtonTap(button)
    }

    @objc fileprivate func nearRightAction(button: EENavigationButton) {
        delegate?.nearRightButtonTap(button)
    }
}

class EENavigationButton: EEButton { }

protocol EENavigationBarProtocol: class {
    func leftButtonTap(_ button: EENavigationButton?)
    func rightButtonTap(_ button: EENavigationButton?)
    func nearRightButtonTap(_ button: EENavigationButton?)
}
