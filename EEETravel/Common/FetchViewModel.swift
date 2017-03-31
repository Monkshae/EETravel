//
//  FetchViewModel.swift
//  EEETravel
//
//  Created by licong on 2017/3/27.
//  Copyright © 2017年 Richard. All rights reserved.
//

import UIKit
typealias JsonType = [String: Any]
enum FetchDataResult: Int {
    case Success = 0
    case Empty = 1
    case Failed = 2
    
    init(rawValue: Int) {
        switch rawValue {
        case 0:
            self = .Success
        case 1:
            self = .Empty
        case 2:
            self = .Failed
        default:
            self = .Failed
        }
    }
}

protocol ViewModelProtocol {
    
    var dataArray: [AnyObject] { get set }
    var api: EEAPI { get set }
    var startNum: Int { get set }
    var message: String { get set }
    var fetchDataResult: FetchDataResult { get set }
    
    /**
     协议中的构造器要求，必须实现init方法
     */
    init()
    
    func fetchRemoteData()
    func willRefresh()
    func willLoadMore()
}

class FetchViewModel: ViewModelProtocol {
    var dataArray = [AnyObject]()
    var api = EEAPI.defaultApi
    var startNum = 0
    var message = ""
    var fetchDataResult = FetchDataResult.Failed
    var parameters = JsonType()

    required init() {
        parameters = ["start_num": startNum, "count": 10]
    }
    
    func buildParameters() {
        parameters["start_num"] = startNum
    }
    
    func fetchRemoteData() {
        EEProvider.request(api) { result in
            var message = "Couldn't access API"
            if case let .success(response) = result {
                let jsonString = try? response.mapString()
                _ = response.statusCode
                message = jsonString ?? message
            }
        }
    }
    
    func willRefresh() {
        
    }
    
    func willLoadMore() {
        
    }
}
