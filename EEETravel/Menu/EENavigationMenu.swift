//
//  EENavigationMenu.swift
//  EEETravel
//
//  Created by licong on 2017/2/3.
//  Copyright © 2017年 Richard. All rights reserved.
//

import UIKit

class EENavigationMenuPageControl: UIPageControl {
    override init(frame: CGRect) {
        super.init(frame: frame)
        pageIndicatorTintColor =  UIColor.separatorLineColor()
        currentPageIndicatorTintColor = UIColor.secondaryTextColor()
        hidesForSinglePage = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}


class EENavigationMenu: UIView {

    var pageControl: EENavigationMenuPageControl!
    var collectionView: UICollectionView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        backgroundColor = UIColor.backgroundColor()
        
        let layout = EENavigationMenuLayout()
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.scrollsToTop = false
        collectionView.register(EENavigationMenuCell.classForCoder(), forCellWithReuseIdentifier: String(describing: EENavigationMenuCell.self))
        
        
        pageControl = EENavigationMenuPageControl(frame: frame)

    }
    

}
