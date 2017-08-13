//
//  RefreshLabel.swift
//  Refresh
//
//  Created by L on 2017/8/8.
//  Copyright © 2017年 L. All rights reserved.
//

import UIKit

class RefreshLabel: UILabel {
    
    class func refreshLabel() -> RefreshLabel {
        
        let label = RefreshLabel()
        label.font = Constant.RefreshLabel.font
        label.textColor = Constant.RefreshLabel.textColor
        label.autoresizingMask = .flexibleWidth
        label.textAlignment = .center
        label.backgroundColor = .clear
        
        return label
    }
    
    var textWidth: CGFloat {
        
        var stringWidth: CGFloat = 0
        
        let size = CGSize(width: .max, height: .max)
        
        guard let text = (text as NSString?), text.length > 0 else { return stringWidth }
        
        stringWidth = text.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil).size.width
        
        return stringWidth
    }
    
}
