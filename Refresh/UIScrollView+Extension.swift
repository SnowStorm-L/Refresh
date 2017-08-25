//
//  UIScrollView+Extension.swift
//  Refresh
//
//  Created by L on 2017/8/25.
//  Copyright © 2017年 L. All rights reserved.
//

import UIKit

extension UIScrollView {
    
    var contentWidth: CGFloat {
        get {
            return contentSize.width
        } set {
            var newContentSize = contentSize
            newContentSize.width = newValue
            contentSize = newContentSize
        }
    }
    
    var contentHeight: CGFloat {
        get {
            return contentSize.height
        } set {
            var newContentSize = contentSize
            newContentSize.height = newValue
            contentSize = newContentSize
        }
    }
    
    var offsetX: CGFloat {
        get {
            return contentOffset.x
        } set {
            var newContentOffset = contentOffset
            newContentOffset.x = newValue
            contentOffset = newContentOffset
        }
    }
    
    var offsetY: CGFloat {
        get {
            return contentOffset.y
        } set {
            var newContentOffset = contentOffset
            newContentOffset.y = newValue
            contentOffset = newContentOffset
        }
    }
    
    var insetTop: CGFloat {
        get {
            return contentInset.top
        } set {
            var newContentInset = contentInset
            newContentInset.top = newValue
            contentInset = newContentInset
        }
    }
    
    var insetBottom: CGFloat {
        get {
            return contentInset.bottom
        } set {
            var newContentInset = contentInset
            newContentInset.bottom = newValue
            contentInset = newContentInset
        }
    }
    
    var insetLeft: CGFloat {
        get {
            return contentInset.left
        } set {
            var newContentInset = contentInset
            newContentInset.left = newValue
            contentInset = newContentInset
        }
    }
    
    var insetRight: CGFloat {
        get {
            return contentInset.right
        } set {
            var newContentInset = contentInset
            newContentInset.right = newValue
            contentInset = newContentInset
        }
    }
    
}
