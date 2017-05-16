//
//  GMBaseController.swift
//  Gengmei
//
//  Created by wangyang on 16/3/21.
//  Copyright © 2017年 Richard. All rights reserved.
//

import UIKit

class EEBaseController: UIViewController {

    /// 如果因为特殊业务不在顶层显示导航，那么设置为true，你需要在业务controller的viewDidLoad中确定navigationBar的位置
    var controlNavigationByYou = false
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        initController()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initController()
    }

    func initController() {
        // 在 initController 中初始化自定义导航栏有很大好处。至少可以保证视图被push之前就可以访问navigationBar，以配置title等属性
        customNavigationBar()
        edgesForExtendedLayout = .all
        automaticallyAdjustsScrollViewInsets = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.backgroundColor()
        if responds(to: #selector(setter: UIViewController.edgesForExtendedLayout)) {
            edgesForExtendedLayout = .all
        }

        addNavigationBar()
        hideLeftButtonForRootController()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // 保证即使在loading的时候，仍然可以后退
        if !controlNavigationByYou {
            view.bringSubview(toFront: navigationBar)
        }
    }
    
    override func didMove(toParentViewController parent: UIViewController?) {
        // 作为childController使用，但不是被push到 UINavigationController时，隐藏导航栏
        super.didMove(toParentViewController: parent)
        if parent != nil && !(parent is UINavigationController) {
            navigationBar.isHidden = true
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 导航栏隐藏在 viewWillAppear 里控制的原因是在viewDidLoad时，有可能 navigationController 与 self 并没有关系
        if navigationController != nil {
            navigationController!.isNavigationBarHidden = true
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // 如果栈内的层级多于一个，隐藏UITabBar
        if (navigationController?.childViewControllers.count)! >= 1 {
            hidesBottomBarWhenPushed = true
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 如果栈内的层级小于等于两个，取消隐藏下面的tabbar
        if (navigationController?.childViewControllers.count)! <= 2 {
            hidesBottomBarWhenPushed = false
        }
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }

    func addComponent(_ component: UIViewController) {
        self.addChildViewController(component)
        self.view.addSubview(component.view)
        component.didMove(toParentViewController: self)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

private var navigationBarAssociationKey: UInt8 = 0

// MARK: - 导航相关
extension UIViewController: EENavigationBarProtocol {
    
    var navigationBar: EENavigationBar {
        get {
            return objc_getAssociatedObject(self, &navigationBarAssociationKey) as! EENavigationBar
        }
        set(newValue) {
            objc_setAssociatedObject(self, &navigationBarAssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    func customNavigationBar() {
        navigationBar = EENavigationBar(frame: CGRect(x: 0, y: 0, width: Constant.screenWidth, height: 64))
    }
    
    func addNavigationBar() {
        navigationBar.delegate = self
        view.addSubview(navigationBar)
    }
    
    func hideLeftButtonForRootController() {
        if navigationController != nil && navigationController!.viewControllers.count == 1 {
            navigationBar.leftButton.isHidden = true
        }
    }
    
    func leftButtonTap(_ button: EENavigationButton?) {
        let newSelf = self as? EEBaseController
        newSelf?.backAction(nil)
    }
    
    func rightButtonTap(_ button: EENavigationButton?) {
        let newSelf = self as? EEBaseController
        newSelf?.rightButtonClicked(nil)
    }
    
    func nearRightButtonTap(_ button: EENavigationButton?) {
        let newSelf = self as? EEBaseController
        newSelf?.nearRightButtonClicked(nil)
    }
}

extension EEBaseController {

    func backAction(_ backButton: EENavigationButton?) {
        // parentViewController 是 UINavigationController 说明是极有可能是 push 进来的，需要进一步判断
        if (parent?.isKind(of: UINavigationController.classForCoder())) != nil {
            let navigation = (parent as! UINavigationController)
            // 如果 presentingViewController 存在，表示有人 present 自己，再并上条件已经在导航器上rootViewController时，直接 dismiss 就好了
            if presentingViewController != nil && navigation.viewControllers.count == 1 {
                dismiss(animated: true, completion: nil)
            } else {
                _ = navigationController?.popViewController(animated: true)
            }
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    
    func rightButtonClicked(_ button: UIButton?) {
        
    }
    
    func nearRightButtonClicked(_ button: UIButton?) {}
}
