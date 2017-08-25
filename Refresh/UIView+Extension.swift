//
//  UIView+Extension.swift
//  Refresh
//
//  Created by L on 2017/8/25.
//  Copyright © 2017年 L. All rights reserved.
//

import UIKit

extension UIView {
    
    var width: CGFloat {
        get {
            return frame.size.width
        } set {
            var newFrame = frame
            newFrame.size.width = newValue
            frame = newFrame
        }
    }
    
    var height: CGFloat {
        get {
            return frame.size.height
        } set {
            var newFrame = frame
            newFrame.size.height = newValue
            frame = newFrame
        }
    }
    
}
