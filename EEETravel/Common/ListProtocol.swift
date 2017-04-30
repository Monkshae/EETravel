//
//  TableViewProtocol.swift
//  test
//
//  Created by wangyang on 16/3/15.
//  Copyright © 2016年 北京更美互动信息科技有限公司. All rights reserved.
//

import UIKit
import Observable
import SnapKit
import PullToRefresh
//import GMRefresh

/// 任何业务controller都可以挂上这个协议以实现list controller的功能
protocol ListProtocol: class /*EmptyViewDelegate*/ {
    associatedtype ViewModelType : ViewModelProtocol // 这里需要一个实现 ViewModelType 的viewModel实例，通过这样一个泛型，可以适应不同的业务需求
    var viewModel: ViewModelType { get set } // 需要controller自己实例化

    /**
     向controller.view中添加一个table，并根据 fetchNow 的情况来判断是否自动请求网络
     - parameter tableStyle: UITableViewStyle
     - parameter now:        true表示立即请求风格
     */
    func addTableView(style tableStyle: UITableViewStyle, fetchNow now: Bool)
    
    func addCollectionView(layout: UICollectionViewLayout, fetchNow now: Bool)
    
    /**
     主动调用该方法以请求数据
     */
    func fetchData()
    
    /**
     刷新UI列表
     */
//    func refreshList()

    /**
     请求完网络，会执行该方法以更新非table cell、section UI
     */
    func updateOtherUIData()
    
    /**
     请求完网络失败或者数据为空，显示一个空白提示View
     */
//    func showEmptyView(type: EmptyViewType)
    
    /**
     设置是否需要刷新和加载更多，默认是都需要。
     另外：使用方法而非属性。少些变量，多些方法，这样可以让协议更简单一些
     
     - parameter need: 是否需要
     */
//    func setNeedHeaderRefresh(need: Bool)
//    func setNeedFooterRefresh(need: Bool)

    /**
     返回空白页面中的文本内容，业务类可以复写此方法以便修改默认文字
     
     - returns
     */
//    func getEmptyText() -> String
}

private var emptyViewAssociationKey: UInt8 = 0
private var tableViewAssociationKey: UInt8 = 0
private var collectionViewAssociationKey: UInt8 = 0
private var listViewAssociationKey: UInt8 = 0

private extension UIScrollView {
    func reloadList() {
        (self as? UITableView)?.reloadData()
        (self as? UICollectionView)?.reloadData()
    }
}

extension ListProtocol where Self: EEBaseController {

//     var emptyView: EmptyView {
//         get {
//            return objc_getAssociatedObject(self, &emptyViewAssociationKey) as! EmptyView
//         }
//         set(newValue) {
//            objc_setAssociatedObject(self, &emptyViewAssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
//         }
//     }

    var tableView: UITableView {
        get {
            return objc_getAssociatedObject(self, &tableViewAssociationKey) as! UITableView
        }
        set(newValue) {
            objc_setAssociatedObject(self, &tableViewAssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }

    var collectionView: UICollectionView {
        get {
            return objc_getAssociatedObject(self, &collectionViewAssociationKey) as! UICollectionView
        }
        set(newValue) {
            objc_setAssociatedObject(self, &collectionViewAssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }

    private var listView: UIScrollView {
        get {
            return objc_getAssociatedObject(self, &listViewAssociationKey) as! UIScrollView
        }
        set(newValue) {
            objc_setAssociatedObject(self, &listViewAssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }

    func addTableView(style tableStyle: UITableViewStyle, fetchNow now: Bool) {
        tableView = UITableView(frame: self.view.bounds, style: tableStyle)
        tableView.backgroundColor = UIColor.backgroundColor()
        tableView.separatorStyle = .none
        manager(list: tableView, fetchNow: now)
    }

    func addCollectionView(layout: UICollectionViewLayout, fetchNow now: Bool) {
        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.separatorLineColor()
        manager(list: collectionView, fetchNow: now)
    }

    private func manager(list: UIScrollView, fetchNow now: Bool) {
        view.addSubview(list)
        list.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(64)
            make.bottom.equalTo(0)
        }
        listView = list

//        emptyView = EmptyView(frame:CGRectMake(0, 0, Constant.screenWidth, Constant.screenHeight))
//        emptyView.hidden = true
//        emptyView.delegate = self
//        (list as? UITableView)?.backgroundView = emptyView
//        (list as? UICollectionView)?.backgroundView = emptyView
//        if !getEmptyText().isEmpty {
//            emptyView.emptyText = self.getEmptyText()
//        }

//        setNeedHeaderRefresh(need: true)
//        setNeedFooterRefresh(need: true)
        addKVO()
        if now {
            fetchData()
        }
    }
    
    func fetchData() {
        if viewModel.isDataArrayEmpty() {
//            showLoading(nil)
        }
        viewModel.fetchRemoteData()
    }

    private func addKVO() {
        _ = viewModel.fetchDataResult.afterChange += { [weak self] in
            self?.observeHandler(newValue: $1)
        }
    }
    
    private func observeHandler(newValue: Int) {
//        hideLoading()
        if newValue == FetchDataResult.Success.rawValue {
            listView.reloadList()
            updateOtherUIData()
            if viewModel.isDataArrayEmpty() {
//                debugLog(viewModel.message)
//                showEmptyView()
            } else {
               hideEmptyView()
            }
        } else {
//            showEmptyView(EmptyViewType.Exception)
        }

        listView.addPullToRefresh(PullToRefresh(position: .top)) { [weak self] in
            self?.viewModel.clearData()
            self?.listView.reloadList()
            self?.fetchData()
            self?.tableView.endRefreshing(at: .top)
        }
    
        listView.addPullToRefresh(PullToRefresh(position: .bottom)) { [weak self] in
            self?.viewModel.willLoadMore()
            self?.fetchData()
            self?.tableView.endRefreshing(at: .bottom)
        }
    }

    func refreshList() {
        self.viewModel.page = 0
        self.listView.reloadList()
        self.fetchData()
    }
    
    func updateOtherUIData() {
        print("Default updateOtherUIData function")
    }
    
//    func showEmptyView(type: EmptyViewType = .Empty) {
//        emptyView.hidden = false
//        if !viewModel.message.isEmpty {
//            emptyView.type = type
//            if type == .Empty {
//                emptyView.emptyText = viewModel.message
//            } else {
//                emptyView.exceptionText = viewModel.message
//            }
//        }
//        emptyView.setNeedsLayout()
//    }
    
    func hideEmptyView() {
//        emptyView.hidden = true
    }
    
    // MARK: - EmptyViewDelegate
    func emptyViewDidClickReload() {
//        refreshList()
    }
    
    func getEmptyText() -> String {
        return ""
    }
}
