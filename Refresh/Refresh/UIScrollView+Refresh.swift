//
//  UIScrollView+Refresh.swift
//  GitCommandLine
//
//  Created by L on 2017/8/3.
//  Copyright © 2017年 L. All rights reserved.
//

import UIKit

extension UIScrollView: SelfAware {
    
    var headerView: UIView? {
        get {
            return objc_getAssociatedObject(self, &Constant.Runtime.associatedHeaderKey) as? UIView
        } set {
            if let newView = newValue, headerView != newValue {
                // 删除旧的
                headerView?.removeFromSuperview()
                insertSubview(newView, at: 0)
                
                
                // htvar://developer.apple.com/library/content/documentation/Cocoa/Conceptual/KeyValueObserving/Articles/KVOCompliance.html#//apple_ref/doc/uid/20002178-BAJEAIEE
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
                willChangeValue(forKey: Constant.KVO.headerView)
                objc_setAssociatedObject(self, &Constant.Runtime.associatedHeaderKey, newView, .OBJC_ASSOCIATION_ASSIGN)
                didChangeValue(forKey: Constant.KVO.headerView)
            }
        }
    }
    
    var footerView: UIView? {
        get {
            return objc_getAssociatedObject(self, Constant.Runtime.associatedFooterKey) as? UIView
        } set {
            if let newView = newValue, footerView != newValue {
                // 删除旧的
                footerView?.removeFromSuperview()
                insertSubview(newView, at: 0)
                
                // 添加新的
                willChangeValue(forKey: Constant.KVO.footerView)
                objc_setAssociatedObject(self, &Constant.Runtime.associatedFooterKey, newView, .OBJC_ASSOCIATION_ASSIGN)
                didChangeValue(forKey: Constant.KVO.footerView)
            }
        }
    }
    
    var reloadDataBlock: ((NSInteger)->Void)? {
        get {
            return objc_getAssociatedObject(self, &Constant.Runtime.associatedReloadDataBlockKey) as? ((NSInteger) -> Void)
        } set {
            willChangeValue(forKey: Constant.KVO.reloadDataBlock)
            objc_setAssociatedObject(self, &Constant.Runtime.associatedReloadDataBlockKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            didChangeValue(forKey: Constant.KVO.reloadDataBlock)
        }
    }
    
    var totalDataCount: NSInteger {
        
        var totalCount = 0
        
        if self is UITableView {
            
            let tableView = self as! UITableView
            
            for idx in 0..<tableView.numberOfSections {
                totalCount += tableView.numberOfRows(inSection: idx)
            }
            
        } else if self is UICollectionView {
            let collectionView = self as! UICollectionView
            for idx in 0..<collectionView.numberOfSections {
                totalCount += collectionView.numberOfItems(inSection: idx)
            }
        }
        
        return totalCount
    }
    
    func executeReloadDataBlock() {
        reloadDataBlock?(totalDataCount)
    }
    
    static func awake() {
        
        if hash() == UITableView.hash() {
            exchangeInstanceMethod(method1: #selector(UITableView.reloadData), method2: #selector(myTableViewReloadData))
        } else if hash() == UICollectionView.hash() {
             exchangeInstanceMethod(method1: #selector(UICollectionView.reloadData), method2: #selector(myCollectionViewReloadData))
        }
    }
    
    @objc dynamic private func myTableViewReloadData() {
        myTableViewReloadData()
        executeReloadDataBlock()
    }
    
    @objc dynamic private func myCollectionViewReloadData() {
        myCollectionViewReloadData()
        executeReloadDataBlock()
    }

}

fileprivate extension NSObject {
    
    class func exchangeInstanceMethod(method1: Selector, method2: Selector) {
        if let m1 = class_getInstanceMethod(self, method1),
            let m2 = class_getInstanceMethod(self, method2) {
            method_exchangeImplementations(m1, m2)
        }
    }
    
}

protocol SelfAware: class {
    static func awake()
}

class NothingToSeeHere {

    static func harmlessFunction() {

        let typeCount = Int(objc_getClassList(nil, 0))
        let types = UnsafeMutablePointer<AnyClass>.allocate(capacity: typeCount)
        let autoreleasingTypes = AutoreleasingUnsafeMutablePointer<AnyClass>(types)
        objc_getClassList(autoreleasingTypes, Int32(typeCount))
        for index in 0 ..< typeCount { (types[index] as? SelfAware.Type)?.awake() }
        types.deallocate(capacity: typeCount)

    }

}

extension UIApplication {

    private static let runOnce: Void = {
        NothingToSeeHere.harmlessFunction()
    }()

    override open var next: UIResponder? {
        // Called before applicationDidFinishLaunching
        UIApplication.runOnce
        return super.next
    }

}

