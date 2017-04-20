//
//  EEHomeViewModel.swift
//  EEETravel
//
//  Created by licong on 2017/4/4.
//  Copyright © 2017年 Richard. All rights reserved.
//

import UIKit

class EEHomeViewModel: FetchViewModel<EEHomeBaseObject> {

    required init() {
        super.init()
        api = .home
    }
    
    override func build(_ data: NSDictionary) {
        let response =  EEHomeObject(dictionary: data)
        dataArray = response.data
    }
    
    func icon(at indexPath: IndexPath) -> String {
        let object = dataArray[indexPath.row]
        return object.icon 
    }
    
    func name(at indexPath: IndexPath) -> String {
        let object = dataArray[indexPath.row]
        return object.name
    }
    
    func title(at indexPath: IndexPath) -> String {
        let object = dataArray[indexPath.row]
        return object.title
    }
    
    func interval(at indexPath: IndexPath) -> String {
        let object = dataArray[indexPath.row]
        let interval = object.interval
        let string = interval.getTimeString()
        return string
    }
    
}
