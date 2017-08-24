//
//  RefreshHeader.swift
//  Refresh
//
//  Created by L on 2017/8/8.
//  Copyright © 2017年 L. All rights reserved.
//

import UIKit

class RefreshHeader: RefreshBase {
    
    /// 忽略多少scrollView的contentInset的top
    var ignoredScrollViewContentInsetTop: CGFloat = 0.0
    
    fileprivate var insetTopDelta: CGFloat = 0.0
    
    //FIXME:- bug
    override var refreshState: RefreshBase.RefreshState {
        didSet {
            if refreshState == oldValue { return }
            
            super.refreshState = refreshState
            
            guard let scrollView = scrollView else {
                return
            }
            
            if refreshState == .default {
                if oldValue != .refreshing { return }
                // 恢复inset和offset
                UIView.animate(withDuration: Constant.AnimationDuration.slow, animations: {
                    scrollView.insetTop += self.insetTopDelta
                    // 自动调整透明度
                    if self.isAutomaticallyChangeAlpha {
                        self.alpha = 0.0
                    }
                }) { (finished) in
                    self.pullingPercent = 0.0
                    self.endRefreshingCompletionBlock?()
                }
            
            } else if refreshState == .refreshing {
                DispatchQueue.main.async {
                    UIView.animate(withDuration: Constant.AnimationDuration.fast, animations: { 
                        let top = self.scrollViewOriginalInset.top + self.height
                        // 增加滚动区域top
                        scrollView.insetTop = top
                        // 设置滚动位置
                        scrollView.setContentOffset(CGPoint(x: 0, y: -top), animated: false)
                    }) { (finished) in
                        self.executeRefreshingCallback()
                    }
                }
            }
            
        }
    }
    
    class func headerRefreshing(refreshingBlock: RefreshingBlock) -> RefreshHeader
    {
        let refreshHeader = RefreshHeader()
        refreshHeader.refreshingBlock = refreshingBlock
        refreshHeader.backgroundColor = .red
        return refreshHeader
    }
    
    override func defalutSetting() {
        super.defalutSetting()
        
        height = Constant.RefreshHeader.defaultHeight
        
    }
    
    override func placeSubviews() {
        super.placeSubviews()
        
        y =  -height - ignoredScrollViewContentInsetTop
        
    }
    
    override func scrollViewContentOffsetDidChange(change: [NSKeyValueChangeKey : Any]?) {
        super.scrollViewContentOffsetDidChange(change: change)
        
        guard let scrollView = scrollView else { return }
        
        // 在刷新的refreshing状态
        if refreshState == .refreshing {
            if window == nil { return }
            // sectionHeader停留解决
            var insetTop = (-scrollView.offsetY > scrollViewOriginalInset.top) ?
                -scrollView.offsetY : scrollViewOriginalInset.top
            
            insetTop = (insetTop > (height + scrollViewOriginalInset.top)) ?
                height + scrollViewOriginalInset.top : insetTop
            
            scrollView.insetTop = insetTop
            
            insetTopDelta = scrollViewOriginalInset.top - insetTop
            
            return
        }
        
        // 跳转到下一个控制器时，contentInset可能会变
        scrollViewOriginalInset = scrollView.contentInset
        
        // 当前的contentOffset
        let offsetY = scrollView.offsetY
        
        // 头部控件刚好出现的offsetY
        let happenOffsetY = -scrollViewOriginalInset.top
        
        // 如果是向上滚动到看不见头部控件，直接返回
        // >= -> >
        if offsetY > happenOffsetY { return }
        
        // 普通 和 即将刷新 的临界点
        let normal2pullingOffsetY = happenOffsetY - height
        let getPullingPercent = (happenOffsetY - offsetY) / height
        
        if scrollView.isDragging { // 如果正在拖拽
            pullingPercent = getPullingPercent
            if refreshState == .default && offsetY < normal2pullingOffsetY {
                // 转为即将刷新状态
                refreshState = .pulling
            } else if refreshState == .pulling && offsetY >= normal2pullingOffsetY {
                // 转为普通状态
                refreshState = .default
            }
        } else if refreshState == .pulling {// 即将刷新 && 手松开
            // 开始刷新
            beginRefreshing()
        } else if getPullingPercent < 1 {
            pullingPercent = getPullingPercent
        }
        
    }

    
}
