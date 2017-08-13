//
//  RefreshFooter.swift
//  Refresh
//
//  Created by L on 2017/8/8.
//  Copyright © 2017年 L. All rights reserved.
//

import UIKit

class RefreshFooter: RefreshBase {
    
    var isAutomaticallyHidden = false
    
    class func footerRefreshing(refreshingBlock: RefreshingBlock) -> RefreshFooter
    {
        let refreshFooter = RefreshFooter()
        refreshFooter.refreshingBlock = refreshingBlock
        refreshFooter.backgroundColor = .blue
        return refreshFooter
    }
    
    override func defalutSetting() {
        super.defalutSetting()
        
        height = Constant.RefreshFooter.defaultHeight
    
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        // 监听scrollView数据的变化
        if let _ = newSuperview as? UIScrollView,
            let scrollView = scrollView
        {
           let isValidate = scrollView.isKind(of: UITableView.self) || scrollView.isKind(of: UICollectionView.self)
            if isValidate {
                
            }
        }
    }
    
    func endRefreshingWithNoMoreData() {
        refreshState = .noMoreData
    }
    
}
