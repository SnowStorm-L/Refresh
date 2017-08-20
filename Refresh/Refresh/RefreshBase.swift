//
//  RefreshBase.swift
//  Refresh
//
//  Created by L on 2017/8/7.
//  Copyright © 2017年 L. All rights reserved.
//

import UIKit

typealias RefreshingBlock = (()->Void)?

class RefreshBase: UIView {
    
    /// 刷新控件的状态
    enum RefreshState: Int {
        case `default` = 1   /// 默认状态
        case pulling         /// 拖拽状态
        case willRefresh  /// 即将刷新状态
        case refreshing      /// 刷新中状态
        case noMoreData      /// 所有数据加载完毕，没有更多的数据状态
    }
    
    var refreshState = RefreshState.default {
        didSet {
            DispatchQueue.main.async {
                self.setNeedsLayout()
            }
        }
    }
    
    var isRefreshing: Bool {
        return refreshState == .refreshing || refreshState == .willRefresh
    }
    
    var isAutomaticallyChangeAlpha: Bool = false {
        didSet {
            if isRefreshing { return }
            alpha = isAutomaticallyChangeAlpha ? pullingPercent : 1.0
        }
    }
    
    /// 记录scrollView刚开始的inset
    var scrollViewOriginalInset = UIEdgeInsets.zero
    
    var beginRefreshingCompletionBlock: (()->Void)?
    var endRefreshingCompletionBlock: (()->Void)?
    
    var refreshingBlock: RefreshingBlock
    
    /// 父控件
    @objc dynamic weak var scrollView: UIScrollView?
    
    /// 拉拽的百分比
    var pullingPercent: CGFloat = 0.0 {
        didSet {
            if isAutomaticallyChangeAlpha && !isRefreshing {
                alpha = pullingPercent
            }
        }
    }
    
    @objc fileprivate dynamic var panGesture: UIPanGestureRecognizer?
    
    // MARK: - life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        defalutSetting()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func layoutSubviews() {
        
        placeSubviews()
        super.layoutSubviews()
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        if let newView = newSuperview as? UIScrollView {
            removeObservers()
            width = newView.width
            x = 0
            scrollView = newView
            scrollView?.alwaysBounceVertical = true
            scrollViewOriginalInset = scrollView?.contentInset ?? .zero
            addObservers()
        }
        
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        if refreshState == .willRefresh {
            refreshState = .refreshing
        }
        
    }
    
    // MARK: - KVO
    
    func addObservers() {
        
        let options: NSKeyValueObservingOptions = [.new, .old]
        scrollView?.addObserver(self, forKeyPath: Constant.KVO.refreshContentOffset, options: options, context: nil)
        scrollView?.addObserver(self, forKeyPath: Constant.KVO.refreshContentSize, options: options, context: nil)
        panGesture = scrollView?.panGestureRecognizer
        panGesture?.addObserver(self, forKeyPath: Constant.KVO.panState, options: options, context: nil)
        
    }
    
    func removeObservers() {
        
        superview?.removeObserver(self, forKeyPath: Constant.KVO.refreshContentOffset)
        superview?.removeObserver(self, forKeyPath: Constant.KVO.refreshContentSize)
        panGesture?.removeObserver(self, forKeyPath: Constant.KVO.panState)
        panGesture = nil
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if !isUserInteractionEnabled { return }
        
        if keyPath == Constant.KVO.refreshContentSize {
            scrollViewContentSizeDidChange(change: change)
        }
        
        if isHidden { return }
        
        if keyPath == Constant.KVO.refreshContentOffset {
            scrollViewContentOffsetDidChange(change: change)
        } else if keyPath == Constant.KVO.panState  {
            scrollViewPanStateDidChange(change: change)
        }
        
    }
    
    
    // MARK: - Refresh State Handler
    
    func beginRefreshing(completion: (()->Void)? = nil) {
        
        beginRefreshingCompletionBlock = completion
        
        UIView.animate(withDuration: Constant.AnimationDuration.fast) {
            self.alpha = 1.0
        }
        
        pullingPercent = 1.0
        
        if let _ = window {
            refreshState = .refreshing
        } else {
            if refreshState != .refreshing {
                refreshState = .willRefresh
                setNeedsDisplay()
            }
        }
        
    }
    
    func endRefreshing(completion: (()->Void)? = nil) {
        
        endRefreshingCompletionBlock = completion
        
        refreshState = .default
    }
    
    func executeRefreshingCallback() {
        DispatchQueue.main.async {
            self.refreshingBlock?()
            self.beginRefreshingCompletionBlock?()
        }
    }
    
    func defalutSetting() {
        autoresizingMask = .flexibleWidth
        backgroundColor = .clear
    }
    
    func scrollViewContentOffsetDidChange(change: [NSKeyValueChangeKey : Any]?)  {
        
    }
    
    func scrollViewContentSizeDidChange(change: [NSKeyValueChangeKey : Any]?) {
        
    }
    
    func scrollViewPanStateDidChange(change: [NSKeyValueChangeKey : Any]?) {
        
    }
    
    func placeSubviews() {
        
    }
    
}
