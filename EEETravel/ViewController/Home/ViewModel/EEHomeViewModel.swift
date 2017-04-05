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
   
    override func buildData(data: String) {
       
    }
    
}
