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
    
    struct Constant {
        struct RefreshFooter {
            static let defaultHeight: CGFloat = 44.0
        }
    }
    
    override func defalutSetting() {
        super.defalutSetting()
        
        height = Constant.RefreshFooter.defaultHeight
    
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        // 监听scrollView数据的变化
       // if let newView = newSuperview as? UIScrollView, let scrollView = scrollView {
           
        //}
    }
    
    func endRefreshingWithNoMoreData() {
        refreshState = .noMoreData
    }
    
}
