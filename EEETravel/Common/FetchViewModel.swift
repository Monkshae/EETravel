//
//  FetchViewModel.swift
//  EEETravel
//
//  Created by licong on 2017/3/27.
//  Copyright © 2017年 Richard. All rights reserved.
//

import UIKit
import Observable

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
    var page: Int { get set }
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

class FetchViewModel: ViewModelProtocol {
    var dataArray = [AnyObject]()
    var api = EEAPI.defaultApi
    var page = 0
    var message = ""
    var fetchDataResult: Observable<Int> = Observable(FetchDataResult.Failed.rawValue)
    var parameters = JsonType()

    required init() {
        parameters = ["page": page]
    }
    
    func buildParameters() {
        parameters["page"] = page
    }
    
    func fetchRemoteData() {
        EEProvider.request(api) { result in
            var message = "Couldn't access API"
            
            switch result {
            case let .success(response):
//                let data = response.data
//                let statusCode = moyaResponse.statusCode
                let jsonString = try? response.mapString()
                _ = response.statusCode
                message = jsonString ?? message
                self.buildData(data: message)
                self.fetchDataResult.value = FetchDataResult.Success.rawValue
            case let .failure(error):
                // this means there was a network failure - either the request
                // wasn't sent (connectivity), or no response was received (server
                // timed out).  If the server responds with a 4xx or 5xx error, that
                // will be sent as a ".success"-ful response.
                self.message = error.errorDescription ?? "网络请求失败，请检查您的网络设置"
                self.fetchDataResult.value = FetchDataResult.Failed.rawValue
            }
        }
    }
    func buildData(data: String) {}

    func willRefresh() {
        
    }
    
    func willLoadMore() {
        
    }
}
