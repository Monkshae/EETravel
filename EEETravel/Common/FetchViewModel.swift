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
    
    var api: EEAPI { get set }
    var page: Int { get set }
    var message: String { get set }
    var fetchDataResult: Observable<Int> { get set }
    
    /**
     协议中的构造器要求，必须实现init方法
     */
    init()
    func isDataArrayEmpty() -> Bool
    func fetchRemoteData()
    func clearData()
    func willRefresh()
    func willLoadMore()
}

class FetchViewModel<T>: ViewModelProtocol {
    var dataArray = [T]()
    var api = EEAPI.defaultApi
    var page = 0
    var message = ""
    var fetchDataResult: Observable<Int> = Observable(FetchDataResult.Failed.rawValue)
    var parameters = JsonType()

    required init() {
        parameters = ["page": page]
    }
    
    func isDataArrayEmpty() -> Bool {
        return dataArray.count == 0
    }
    
//    func buildParameters() {
//        parameters["page"] = page
//    }
    
    func fetchRemoteData() {
        api = .home(page)
        EEProvider.request(api) { result in
//            var message = "Couldn't access API"
            switch result {
            case let .success(response):

                let  jsonResponse = try? response.mapJSON()
                guard let json = jsonResponse as? NSDictionary else { return }
                if let message = json["message"] as? String {
                    self.message = message
                }
                if json["data"] == nil {
                    return
                }
                
                self.build(json)
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
    func build(_ data: NSDictionary) {}

    func clearData() {
        page = 0
        dataArray.removeAll()
    }
    
    func willRefresh() {
        page = 0
    }
    
    func willLoadMore() {
        page += 1
    }
}
