//
//  EView.swift
//  EEETravel
//
//  Created by licong on 2016/11/23.
//  Copyright © 2016年 Richard. All rights reserved.
//

import UIKit

class EEView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func setup() {
        
    }

}
