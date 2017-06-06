//
//  ShareView.swift
//  EEETravel
//
//  Created by licong on 2017/4/18.
//  Copyright © 2017年 Richard. All rights reserved.
//

import UIKit
import MonkeyKing

class ShareViewCell: EEView {
    public typealias ShareCellClickedHandler = () -> Void
    public var icon = EEImageView()
    public var label: EELabel!
    fileprivate var shareCellClickedHandler: ShareCellClickedHandler?

    override func setup() {
        super.setup()
        addSubview(icon)
        label = EELabel.label(.center, UIColor.bodyText, 12)
        addSubview(label)
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction(gesture:)))
        addGestureRecognizer(tap)
    }
    
    @objc private func tapAction(gesture: UITapGestureRecognizer) {
        shareCellClickedHandler?()
    }
    
    fileprivate static func shareCell(_ image: UIImage, _ title: String) -> ShareViewCell {
        let cell = ShareViewCell()
        cell.icon.image = image
        cell.label.text = title
        return cell
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        icon.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.size.equalTo(CGSize(width: 54, height: 54))
        }
        label.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(icon.snp.bottom).offset(6)
            make.bottom.equalTo(0)
        }
    }
}

protocol ShareViewDelegate: class {
    func fetchSharePublishContent(with index: Int) -> MonkeyKing.Message?
    func shareView(_ shareView: ShareView, didSelectAt index: Int)
}

extension ShareViewDelegate {
    func fetchSharePublishContent(with index: Int) -> MonkeyKing.Message? {
        return nil
    }
    
    func shareView(_ shareView: ShareView, didSelectAt index: Int) {
        
    }
}

class ShareView: EEView {
    
    public var dimmingView = EEImageView()
    public var contentView = EEView()
    public weak var delegate: ShareViewDelegate?
    override func setup() {
        super.setup()
        dimmingView.backgroundColor = UIColor(white: 0, alpha: 0)
        addSubview(dimmingView)
        dimmingView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets.zero)
        }
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction(gesture:)))
        dimmingView.addGestureRecognizer(tap)
        
        dimmingView.addSubview(contentView)
        contentView.backgroundColor = UIColor.white
        contentView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(180)
            make.height.equalTo(180)
        }
    }
    
    public func shareContent(at index: Int) {
        guard let message = delegate?.fetchSharePublishContent(with: index) else { return }
        MonkeyKing.deliver(message) { success in
            print("shareURLToWeChatSession success: \(success)")
        }
    }
    
    public func showShareView() {
        isHidden = false
        UIView.animate(withDuration: 0.25) {
            self.dimmingView.backgroundColor = UIColor(white: 0, alpha: 0.7)
            self.contentView.snp.updateConstraints({ (make) in
                make.bottom.equalTo(0)
            })
        }
        layoutIfNeeded()
    }
    
    
    public func hideShareView() {
        isHidden = false
        UIView.animate(withDuration: 0.3) {
            self.dimmingView.backgroundColor = UIColor(white: 0, alpha: 0)
        }
        
        UIView.animate(withDuration: 0.25, animations: {
            self.contentView.snp.updateConstraints({ (make) in
                make.bottom.equalTo(self.contentView.height)
            })
        }) { (completion)  in
            self.isHidden  = true
        }
        layoutIfNeeded()
    }
    
    private func setupCells() {
        let weiboCell = ShareViewCell.shareCell(UIImage(named: "live_sina_share")!, "微博")
        contentView.addSubview(weiboCell)
        weiboCell.shareCellClickedHandler = { [unowned self] in
            self.delegate?.shareView(self, didSelectAt: 0)
        }
        weiboCell.snp.makeConstraints { (make) in
            make.top.equalTo(28)
            make.left.equalTo(30)
        }
        let wechatCell = ShareViewCell.shareCell(UIImage(named: "live_wechat_share")!, "微信")
        contentView.addSubview(wechatCell)
        wechatCell.shareCellClickedHandler = { [unowned self] in
            self.delegate?.shareView(self, didSelectAt: 1)
        }
        wechatCell.snp.makeConstraints { (make) in
            make.top.equalTo(28)
            make.left.equalTo(weiboCell.snp.right).offset((Constant.screenWidth - 60 - 54 * 4)/3)
        }
        let wechatTimelineCell = ShareViewCell.shareCell(UIImage(named: "live_wechat_timeline_share")!, "朋友圈")
        contentView.addSubview(wechatTimelineCell)
        wechatTimelineCell.shareCellClickedHandler = { [unowned self] in
            self.delegate?.shareView(self, didSelectAt: 2)
        }
        wechatTimelineCell.snp.makeConstraints { (make) in
            make.top.equalTo(28)
            make.left.equalTo(wechatCell.snp.right).offset((Constant.screenWidth - 60 - 54 * 4)/3)
        }
        let qqCell = ShareViewCell.shareCell(UIImage(named: "live_qq_share")!, "QQ")
        contentView.addSubview(qqCell)
        qqCell.shareCellClickedHandler = { [unowned self] in
            self.delegate?.shareView(self, didSelectAt: 0)
        }
        qqCell.snp.makeConstraints { (make) in
            make.top.equalTo(28)
            make.left.equalTo(wechatTimelineCell.snp.right).offset((Constant.screenWidth - 60 - 54 * 4)/3)
        }
    }
    
    private func setupCancelButton() {
        let line = contentView.addHorizontalLine(top: 130)
        let cancelButton = EEButton(type: .custom)
        cancelButton.titleLabel?.font = EEFont(size: 14)
        cancelButton.setTitle("取消", for: .normal)
        cancelButton.setTitleColor(UIColor.headlineText, for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelButtonAction(button:)), for: .touchUpInside)
        contentView.addSubview(cancelButton)
        cancelButton.snp.makeConstraints { (make) in
            make.top.equalTo(line.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(-15)
        }
    }
    
    @objc private func cancelButtonAction(button: EEButton) {
        
    }
    
    // MARK: 手势响应事件
    @objc private func tapAction(gesture: UITapGestureRecognizer) {
    
    }
    
}
