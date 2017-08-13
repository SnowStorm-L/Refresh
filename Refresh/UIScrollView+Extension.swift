//
//  UIScrollView+Extension.swift
//  Extension
//
//  Created by xueyefengbao on 2016/12/7.
//  Copyright © 2016年 bestidear. All rights reserved.
//

import UIKit

extension UIScrollView {

    /// 内容顶部坐标
    var insetTop: CGFloat {

        get { return contentInset.top }

        set (newValue) {

            var inset = contentInset
            inset.top = newValue
            contentInset = inset

        }

    }


    /// 内容顶部坐标
    var insetBottom: CGFloat {

        get { return contentInset.bottom }

        set (newValue) {

            var inset = contentInset
            inset.bottom = newValue
            contentInset = inset

        }

    }

    /// 内容左坐标
    var insetLeft: CGFloat {

        get { return contentInset.left }

        set (newValue) {

            var inset = contentInset
            inset.left = newValue
            contentInset = inset

        }

    }

    /// 内容右坐标
    var insetRight: CGFloat {

        get { return contentInset.right }

        set (newValue) {

            var inset = contentInset
            inset.right = newValue
            contentInset = inset

        }

    }

    /// 内容X坐标
    var offsetX: CGFloat {

        get { return contentOffset.x }

        set (newValue) {

            var offset = contentOffset
            offset.x = newValue
            contentOffset = offset

        }

    }


    /// 内容Y坐标
    var offsetY: CGFloat {

        get { return contentOffset.y }

        set (newValue) {

            var offset = contentOffset
            offset.y = newValue
            contentOffset = offset

        }

    }


    /// 内容宽度
    var contentWidth: CGFloat {

        get { return contentSize.width }

        set (newValue) {

            var content = contentSize
            content.width = newValue
            contentSize = content

        }

    }


    /// 内容高度
    var contentHeight: CGFloat {

        get { return contentSize.height }

        set (newValue) {

            var content = contentSize
            content.height = newValue
            contentSize = content

        }

    }


}
