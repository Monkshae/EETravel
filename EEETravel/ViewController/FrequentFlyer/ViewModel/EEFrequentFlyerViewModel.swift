//
//  EEFrequentFlyerViewModel.swift
//  EEETravel
//
//  Created by licong on 2017/5/1.
//  Copyright © 2017年 Richard. All rights reserved.
//

import UIKit

class EEFrequentFlyerViewModel: FetchViewModel<EEHomeBaseObject> {
    required init() {
        super.init()
        api = .home(page, EEKey.frequentFlyerTagId)
    }
    
    override func buildParameters() {
        api = .home(page, EEKey.frequentFlyerTagId)
    }
    
    override func build(_ data: NSDictionary) {
        let response =  EEHomeObject(dictionary: data)
        if page == 0 {
            dataArray = response.data
        } else {
            dataArray.append(contentsOf: response.data)
        }
    }
    
    func icon(at indexPath: IndexPath) -> String {
        let object = dataArray[indexPath.row]
        return EEServerDomain.APIHost + object.icon
    }
    
    func name(at indexPath: IndexPath) -> String {
        let object = dataArray[indexPath.row]
        return object.name
    }
    
    func title(at indexPath: IndexPath) -> String {
        let object = dataArray[indexPath.row]
        return object.title
    }
    
    func url(at indexPath: IndexPath) -> String {
        let object = dataArray[indexPath.row]
        return object.url
    }
    
    func interval(at indexPath: IndexPath) -> String {
        let object = dataArray[indexPath.row]
        let interval = object.interval
        let string = interval.getTimeString()
        return string
    }
}
