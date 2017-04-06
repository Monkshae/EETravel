//
//  EEClientH5Object.swift
//  GMDoctor
//
//  Created by Terminator on 16/8/2.
//  Copyright © 2016年 Gengmei. All rights reserved.
//

import UIKit
import JavaScriptCore

///  @brief  在这里声明js对象所有绑定的方法(名字要和js注册的方法保持一致),命名规范以JS端为准
protocol EEClientH5BridgeDelegate: JSExport {
    
    /***  @brief  弹出loading框*/
    func showLoading()
    
    /***  @brief  隐藏loading*/
    func hideLoading()
    
    /***  @brief  Alert弹窗（只有一个确认按钮）*/
    func showAlert(JSONString: String)
    
    /***  @brief  Confirm弹窗（确认和取消按钮*/
    func showConfirm(JSONString: String)
    
    /***  @brief  toast弹窗*/
    func showToast(JSONString: String)
    
    /***  @brief  打开外部浏览器*/
    func openBrowser(url: String)
    
}

protocol GMClientH5BridgeDelegate: class {
    
    /***  @brief  弹出loading框*/
    func jsShowLoading()
    
    /***  @brief  隐藏loading*/
    func jsHideLoading()
    
    /***  @brief  Alert弹窗（只有一个确认按钮）*/
    func jsShowAlertViewWithJSONString(JSONString: String)
    
    /***  @brief  Confirm弹窗（确认和取消按钮*/
    func jsShowConfirmViewWithJSONString(JSONString: String)
   
    /***  @brief  toast弹窗*/
    func jsShowToastWithJSONString(JSONString: String)
    
    /***  @brief  打开外部浏览器*/
    func jsOpenBrowser(_ url: String)
    
}

class EEClientH5Object: NSObject, EEClientH5BridgeDelegate {

    weak var delegate: GMClientH5BridgeDelegate?
    
    func showLoading() {
        DispatchQueue.main.async {
            self.delegate?.jsShowLoading()
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            self.delegate?.jsHideLoading()
        }
    }
    
    func showAlert(JSONString: String) {
        DispatchQueue.main.async {
            self.delegate?.jsShowAlertViewWithJSONString(JSONString: JSONString)
        }
    }
    
    func showConfirm(JSONString: String) {
        DispatchQueue.main.async {
            self.delegate?.jsShowConfirmViewWithJSONString(JSONString: JSONString)
        }
    }
    
    func showToast(JSONString: String) {
        DispatchQueue.main.async {
            self.delegate?.jsShowToastWithJSONString(JSONString: JSONString)
        }
    }
    
    func openBrowser(url: String) {
        DispatchQueue.main.async {
            self.delegate?.jsOpenBrowser(url)
        }
    }

}
