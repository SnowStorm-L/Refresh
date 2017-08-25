//
//  UIScrollView+Refresh.swift
//  Refresh
//
//  Created by L on 2017/8/25.
//  Copyright © 2017年 L. All rights reserved.
//

import UIKit

extension UIScrollView {
    
    var headerView: UIView? {
        get {
            return objc_getAssociatedObject(self, &Constant.AssociatedKey.header) as? UIView
        } set {
            objc_setAssociatedObject(self, &Constant.AssociatedKey.header, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var footerView: UIView? {
        get {
            return objc_getAssociatedObject(self, &Constant.AssociatedKey.footer) as? UIView
        } set {
            objc_setAssociatedObject(self, &Constant.AssociatedKey.footer, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func addObserver() {
        let options: NSKeyValueObservingOptions = [.new, .old]
        addObserver(self, forKeyPath: Constant.KVO.contentOffSet, options: options, context: nil)
        addObserver(self, forKeyPath: Constant.KVO.contentSize, options: options, context: nil)
    }
    
    func removeObserver() {
        removeObserver(self, forKeyPath: Constant.KVO.contentOffSet)
        removeObserver(self, forKeyPath: Constant.KVO.contentSize)
    }
    
}

protocol SelfAware: class {
    func awake()
}

class NothingTosee {
    
    class func doHarmlessFunc() {
        let classList = objc_getClassList(nil, 0)
        
    }
    
}

extension UIApplication {
    
    fileprivate static let runOne = {
         NothingTosee.doHarmlessFunc()
    }
    
    open override var next: UIResponder? {
        UIApplication.runOne()
        return super.next
    }
    
}
