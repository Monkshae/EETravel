//
//  EENavigationMenuLayout.swift
//  EEETravel
//
//  Created by licong on 2017/2/4.
//  Copyright © 2017年 Richard. All rights reserved.
//

import UIKit

class EENavigationMenuLayout: UICollectionViewLayout {
    open var horizontalItemCount: Int = 4             //每一页的竖直一列放的个数
    open var verticalItemCount: Int = 4               //每一页的水平一行放的个数
    open var minimumLineSpcing: CGFloat = 10              //行间距
    open var minimumInteritemSpacing: CGFloat = 10        //item水平间距
    open var itemSize = CGSize.zero    //item大小
    open var sectionInset = UIEdgeInsets.zero
    
    
    override func prepare() {
        super.prepare()
        let innerHorizontalCount = horizontalItemCount - 1 // 行间距的个数
        let innerverticalCount = verticalItemCount - 1     // item水平间距的个数
        let width = (Constant.screenWidth - sectionInset.left - sectionInset.right - CGFloat(innerHorizontalCount) * minimumInteritemSpacing) / CGFloat(horizontalItemCount)
        let height = (Constant.screenHeight - sectionInset.top - sectionInset.bottom - CGFloat(innerverticalCount) * minimumLineSpcing) / CGFloat(verticalItemCount)
        itemSize = CGSize(width: width, height: height)
    }
    
    override var collectionViewContentSize: CGSize {
        guard collectionView != nil else {
            return CGSize.zero
        }
        let itemCount = collectionView?.numberOfItems(inSection: 0)
        let pages = Double(itemCount! / (horizontalItemCount * horizontalItemCount))
        let size = CGSize(width: CGFloat(ceil(pages)) * (collectionView?.frame.width)!, height: (collectionView?.frame.height)!)
        return size
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var allAttributes =  [UICollectionViewLayoutAttributes]()
        guard collectionView != nil else {
            return nil
        }
        let count = collectionView?.numberOfItems(inSection: 0)
        for index in 0...count! {
            let indexPath = NSIndexPath(row: index, section: 0)
            let attri = layoutAttributesForItem(at: indexPath as IndexPath)
            allAttributes.append(attri!)
        }
        return allAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard collectionView != nil else {
            return nil
        }
        let row = indexPath.row
        let bounds = collectionView?.bounds
        // 第几行
        let columnPosition = row % horizontalItemCount
        // 第几列
        let rowPosition = row / horizontalItemCount % verticalItemCount
        // 第几页
        let itemPage = row / horizontalItemCount * verticalItemCount
        let x = sectionInset.left + CGFloat(columnPosition) * (itemSize.width + minimumInteritemSpacing) * CGFloat(itemPage) * (bounds?.width)!
        let y = sectionInset.top + CGFloat(rowPosition) * (itemSize.height + minimumLineSpcing)
        let atrri = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        atrri.frame = CGRect(x: x, y: y, width: itemSize.width, height: itemSize.height)
        return atrri
    }
}
