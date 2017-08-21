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
    
    var ignoredScrollViewContentInsetBottom: CGFloat = 0.0
    
    fileprivate var lastBottomDelta: CGFloat = 0.0
    fileprivate var lastRefreshCount: NSInteger = 0
    
    class func footerRefreshing(refreshingBlock: RefreshingBlock) -> RefreshFooter
    {
        let refreshFooter = RefreshFooter()
        refreshFooter.refreshingBlock = refreshingBlock
        refreshFooter.backgroundColor = .blue
        return refreshFooter
    }
        
    override var refreshState: RefreshBase.RefreshState {
        didSet {
            if refreshState == oldValue { return }
            super.refreshState = refreshState
            
            guard let scrollView = scrollView else {
                return
            }
            // 根据状态来设置属性
            if refreshState == .noMoreData || refreshState == .default {
                // 刷新完毕
                if oldValue == .refreshing {
                    UIView.animate(withDuration: Constant.AnimationDuration.slow, animations: {
                        scrollView.insetBottom -= self.lastBottomDelta
                        // 自动调整透明度
                        if self.isAutomaticallyChangeAlpha { self.alpha = 0.0 }
                    }) { (finished) in
                        self.pullingPercent = 0.0
                        self.endRefreshingCompletionBlock?()
                    }
                }
                let deltalHeight = heightForContentBreakView()
                // 刚刷新完毕
                if oldValue == .refreshing &&
                    deltalHeight > 0 &&
                    scrollView.totalDataCount != lastRefreshCount
                {
                    self.scrollView?.offsetY = scrollView.offsetY
                }
            } else if refreshState == .refreshing {
                // 记录刷新前的数量
                lastRefreshCount = scrollView.totalDataCount
                
                UIView.animate(withDuration: Constant.AnimationDuration.fast, animations: {
                    var bottom = self.height + self.scrollViewOriginalInset.bottom
                    let deltaHeight = self.heightForContentBreakView()
                    if (deltaHeight < 0) { // 如果内容高度小于view的高度
                        bottom -= deltaHeight
                    }
                    self.lastBottomDelta = bottom - scrollView.insetBottom
                    scrollView.insetBottom = bottom
                    scrollView.offsetY = self.happenOffsetY() + self.height
                }) { (finished) in
                    self.executeRefreshingCallback()
                }
                
            }
            
        }
    }
    
    override func defalutSetting() {
        super.defalutSetting()
        
        height = Constant.RefreshFooter.defaultHeight
        
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)

        if newSuperview != nil, let scrollView = scrollView {
            if scrollView.isKind(of: UITableView.self) || scrollView.isKind(of: UICollectionView.self) {
                scrollView.reloadDataBlock = { (totalDataCount) in
                    if self.isAutomaticallyHidden {
                        self.isHidden = totalDataCount == 0
                    }
                }
            }
        }
        scrollViewContentSizeDidChange(change: nil)
    }
    
    override func scrollViewContentOffsetDidChange(change: [NSKeyValueChangeKey : Any]?) {
        super.scrollViewContentOffsetDidChange(change: change)
        
        // 如果正在刷新，直接返回
        guard let scrollView = scrollView, refreshState != .refreshing else {
            return
        }
        
        scrollViewOriginalInset = scrollView.contentInset
        
        // 当前的contentOffset
        let currentOffsetY = scrollView.offsetY
        
        // 尾部控件刚好出现的offsetY
        let happenOffsetY = self.happenOffsetY()
        
        // 如果是向下滚动到看不见尾部控件，直接返回
        if currentOffsetY <= happenOffsetY { return }
        
        let pullingPercent = (currentOffsetY - happenOffsetY) / height
        
        if refreshState == .noMoreData {
            self.pullingPercent = pullingPercent
            return
        }
        
        if (scrollView.isDragging) {
            
            self.pullingPercent = pullingPercent
            
            // 普通 和 即将刷新 的临界点
            let normal2pullingOffsetY = happenOffsetY + height
            
            if refreshState == .default && currentOffsetY > normal2pullingOffsetY {
                // 转为即将刷新状态
                refreshState = .pulling
            } else if refreshState == .pulling && currentOffsetY <= normal2pullingOffsetY {
                // 转为普通状态
                refreshState = .default
            }
        } else if refreshState == .pulling {// 即将刷新 && 手松开
            // 开始刷新
            beginRefreshing()
        } else if pullingPercent < 1 {
            self.pullingPercent = pullingPercent
        }
        
    }
    
    override func scrollViewContentSizeDidChange(change: [NSKeyValueChangeKey : Any]?) {
        super.scrollViewContentSizeDidChange(change: change)
        // 内容的高度
        if let scrollView = scrollView {
            let contentHeight = scrollView.contentHeight + ignoredScrollViewContentInsetBottom
            let scrollHeight = scrollView.height - scrollViewOriginalInset.top - scrollViewOriginalInset.bottom + ignoredScrollViewContentInsetBottom
            // 设置位置和尺寸
            y = max(contentHeight, scrollHeight)
        }
    }
    
    func endRefreshingWithNoMoreData() {
        refreshState = .noMoreData
    }
    
    fileprivate func heightForContentBreakView() -> CGFloat {
        
        guard let scrollView = scrollView else {
            return 0
        }
        let h = (scrollView.height - scrollViewOriginalInset.bottom - scrollViewOriginalInset.top)
        return scrollView.contentHeight - h
    }
    
    fileprivate func happenOffsetY() -> CGFloat {
        
        let deltaH = heightForContentBreakView()
        
        return deltaH > 0 ? (deltaH - scrollViewOriginalInset.top) : (-scrollViewOriginalInset.top)
    }
    
}
