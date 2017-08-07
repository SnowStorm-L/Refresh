//
//  UIScrollView+Refresh.swift
//  GitCommandLine
//
//  Created by L on 2017/8/3.
//  Copyright © 2017年 L. All rights reserved.
//

import UIKit

extension UIScrollView {
    
    fileprivate struct Constant {
        
        static let refreshHeaderKey = UnsafePointer<Any>.init(bitPattern: "headerKey".hashValue)
        static let refreshFooterKey = UnsafePointer<Any>.init(bitPattern: "footerKey".hashValue)
        
        static let headerView = "headerView"
        static let footerView = "footerView"
    }
    
    var headerView: UIView? {
        get {
            return objc_getAssociatedObject(self, Constant.refreshHeaderKey) as? UIView
        } set {
             if let newView = newValue, headerView != newValue {
                // 删除旧的
                headerView?.removeFromSuperview()
                insertSubview(newView, at: 0)
                
                
                // https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/KeyValueObserving/Articles/KVOCompliance.html#//apple_ref/doc/uid/20002178-BAJEAIEE
                /*
                 正确使用-will | didChangeValueForKey：
                 是在不使用符合KVC的访问器/设置器的情况下修改属性
                 使KVO机制会注意到这种变化。
                 */
                
                /*
                 KVC NSObject(NSKeyValueCoding) 
                 您可以通过名称或键(setValue(_:forKey:)|value(forKey:)),间接访问对象的属性的机制。
                 
                 KVO NSObject(NSKeyValueObserverRegistration)
                 
                 Key-Value Observing (KVO) 建立在 KVC 之上，
                 它能够观察一个对象的 KVC key path 值的变化 所以要KVO,它的类必须符合KVC
                 
                 例如 @public { int } 又不写setter,getter,这些不符合条件(KVC)
                 所以要用will/didChange 把修改值放到2个方法之间 KVO就可以监听到了 这种监听属于手动更改通知(看链接)
                 */
                
                // 添加新的
                willChangeValue(forKey: Constant.headerView)
                objc_setAssociatedObject(self, Constant.refreshHeaderKey, newView, .OBJC_ASSOCIATION_ASSIGN)
                didChangeValue(forKey: Constant.headerView)
            }
        }
    }

    var footerView: UIView? {
        get {
           return objc_getAssociatedObject(self, Constant.refreshFooterKey) as? UIView
        } set {
            if let newView = newValue, footerView != newValue {
                // 删除旧的
                footerView?.removeFromSuperview()
                insertSubview(newView, at: 0)
                
                // 添加新的
                willChangeValue(forKey: Constant.footerView)
                objc_setAssociatedObject(self, Constant.refreshFooterKey, newView, .OBJC_ASSOCIATION_ASSIGN)
                didChangeValue(forKey: Constant.footerView)
            }
        }
    }
    
}
