//
//  RefreshConstant.swift
//  Refresh
//
//  Created by L on 2017/8/13.
//  Copyright © 2017年 L. All rights reserved.
//

import UIKit

struct Constant {
    
    struct KVO {
        static let refreshContentOffset = "contentOffset"
        static let refreshContentSize = "contentSize"
        static let panState = "state"
        
        static let headerView = "headerView"
        static let footerView = "footerView"
    }
    
    struct AnimationDuration {
        static let fast = 0.25
        static let slow = 0.4
    }
    
    struct Runtime {
        static var associatedHeaderKey = "headerKey"
        static var associatedFooterKey = "footerKey"
    }
    
    struct RefreshFooter {
        static let defaultHeight: CGFloat = 44.0
    }
    
    
    struct RefreshHeader {
        static let defaultHeight: CGFloat = 54.0
    }
    
    struct RefreshLabel {
        static let font = UIFont.boldSystemFont(ofSize: 14)
        static let textColor = UIColor(red: 90/255.0, green: 90/255.0, blue: 90/255.0, alpha: 1.0)
    }
    
}

