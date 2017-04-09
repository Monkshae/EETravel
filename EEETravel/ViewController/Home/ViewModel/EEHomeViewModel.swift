//
//  EEHomeViewModel.swift
//  EEETravel
//
//  Created by licong on 2017/4/4.
//  Copyright © 2017年 Richard. All rights reserved.
//

import UIKit

class EEHomeViewModel: FetchViewModel {

    required init() {
        super.init()
        api = .home
    }
   
//    var array = [EEHomeObject]()
    
    override func buildData(data: String) {
        dataArray = [EEHomeObject](json:data)
    }
    
    func icon(at indexPath: IndexPath) -> String {
        let object = dataArray[indexPath.row] as! EEHomeObject
        return object.data?.icon ?? ""
    }
    
    func name(at indexPath: IndexPath) -> String {
        let object = dataArray[indexPath.row] as! EEHomeObject
        return object.data?.name ?? ""
    }
    
    
    func title(at indexPath: IndexPath) -> String {
        let object = dataArray[indexPath.row] as! EEHomeObject
        return object.data?.title ?? ""
    }
    
    func interval(at indexPath: IndexPath) -> String {
        let object = dataArray[indexPath.row] as! EEHomeObject
        let interval = object.data?.interval ?? ""
        let string = interval.getTimeString()
        return string
    }
    
    
    
    
}
