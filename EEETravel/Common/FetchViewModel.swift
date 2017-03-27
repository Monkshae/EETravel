//
//  FetchViewModel.swift
//  EEETravel
//
//  Created by licong on 2017/3/27.
//  Copyright © 2017年 Richard. All rights reserved.
//

import UIKit
import Observable

class FetchViewModel: NSObject {

}


protocol ViewModelProtocol {
    
    var dataArray: [AnyObject] { get set }
    var url: String { get set }
    var startNum: Int { get set }
    var message: String { get set }
    var fetchDataResult: Observable<Int> { get set }
    
    /**
     协议中的构造器要求，必须实现init方法
     */
    init()
    
    func fetchRemoteData()
    func willRefresh()
    func willLoadMore()
}
