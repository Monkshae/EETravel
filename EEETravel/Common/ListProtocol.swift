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

let headerIdentifer = "headerIdentifer"
let footerIdentifer = "footerIdentifer"

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
    
    func removePullToRefresh()
    
    /**
     请求完网络失败或者数据为空，显示一个空白提示View
     */
//    func showEmptyView(type: EmptyViewType)
    
    /**
     设置是否需要刷新和加载更多，默认是都需要。
     另外：使用方法而非属性。少些变量，多些方法，这样可以让协议更简单一些
     
     - parameter need: 是否需要
     */
    func setNeedHeaderRefresh(need: Bool)
    func setNeedFooterRefresh(need: Bool)

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
        tableView.backgroundColor = UIColor.background
        tableView.separatorStyle = .none
        manager(list: tableView, fetchNow: now)
    }

    func addCollectionView(layout: UICollectionViewLayout, fetchNow now: Bool) {
        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.separatorLine
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
        setNeedHeaderRefresh(need: true)
        setNeedFooterRefresh(need: true)
        addKVO()
        if now {
            fetchData()
        }
    }
    
    func fetchData() {
        if viewModel.isDataArrayEmpty() {
        }
        viewModel.fetchRemoteData()
    }

    private func addKVO() {
        _ = viewModel.fetchDataResult.afterChange += { [weak self] in
            self?.observeHandler(newValue: $1)
        }
    }
    
    private func observeHandler(newValue: Int) {
        let topState = listView.topPullToRefresh?.state
        if topState == .loading {
            listView.endRefreshing(at: .top)
        }
        
        let bottomState = listView.bottomPullToRefresh?.state
        if bottomState == .loading {
            listView.endRefreshing(at: .bottom)
        }
        
        if newValue == FetchDataResult.Success.rawValue {
            listView.reloadList()
            updateOtherUIData()
            if viewModel.isDataArrayEmpty() {
                
            } else {
                
            }
        } else { }
    }

    func refreshList() {
        self.viewModel.page = 0
        self.listView.reloadList()
        self.fetchData()
    }
    
    func updateOtherUIData() {
        print("Default updateOtherUIData function")
    }
    
    func removePullToRefresh() {
        
    }
    
    func setNeedHeaderRefresh(need: Bool) {
        if need {
            let header = PullToRefresh(position: .top)
            listView.addPullToRefresh(header) { [weak self] in
                self?.viewModel.willRefresh()
                self?.fetchData()
            }
        } else {
            
        }
    }
    
    func setNeedFooterRefresh(need: Bool) {
        if need {
            let footer = PullToRefresh(position: .bottom)
            listView.addPullToRefresh(footer) { [weak self] in
                self?.viewModel.willLoadMore()
                self?.fetchData()
            }
        } else {
    
        }
    }

}
