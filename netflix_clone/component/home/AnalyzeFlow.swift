//
//  AnalyzeFlow.swift
//  netflix_clone
//
//  Created by Sang Hyeon kim on 2023/07/09.
//

import UIKit

class AnalyzeFlow: NSObject, UICollectionViewDelegateFlowLayout {

    //    https://ios-development.tistory.com/1020
    func scrollViewWillEndDragging(
        _ scrollView: UIScrollView,
        withVelocity velocity: CGPoint,
        targetContentOffset: UnsafeMutablePointer<CGPoint>
    ) {
        
        Log.warning("??", "SCROLL")
        let scrolledOffsetX = targetContentOffset.pointee.x + scrollView.contentInset.left
        //        Paging.itemSize.width + Paging.itemSpacing
        let cellWidth = Paging.itemSize.width + Paging.itemSpacing
        let index = round(scrolledOffsetX / cellWidth)
        targetContentOffset.pointee = CGPoint(x: index * cellWidth - scrollView.contentInset.left, y: scrollView.contentInset.top)
    }
}

enum Paging {
    static let itemSize = CGSize(width: UIScreen.main.bounds.width * 0.825, height: 300)
    static let itemSpacing = 20.0
    
    static var insetX: CGFloat {
        (UIScreen.main.bounds.width - Self.itemSize.width) / 2.0
    }
    static var collectionViewContentInset: UIEdgeInsets {
        UIEdgeInsets(top: 0, left: Self.insetX, bottom: 0, right: Self.insetX)
    }
}
