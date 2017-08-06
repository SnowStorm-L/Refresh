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

        get { return self.contentInset.top }

        set (newValue) {

            var inset = self.contentInset
            inset.top = newValue
            self.contentInset = inset

        }

    }


    /// 内容顶部坐标
    var insetBottom: CGFloat {

        get { return self.contentInset.bottom }

        set (newValue) {

            var inset = self.contentInset
            inset.bottom = newValue
            self.contentInset = inset

        }

    }

    /// 内容左坐标
    var insetLeft: CGFloat {

        get { return self.contentInset.left }

        set (newValue) {

            var inset = self.contentInset
            inset.left = newValue
            self.contentInset = inset

        }

    }

    /// 内容右坐标
    var insetRight: CGFloat {

        get { return self.contentInset.right }

        set (newValue) {

            var inset = self.contentInset
            inset.right = newValue
            self.contentInset = inset

        }

    }

    /// 内容X坐标
    var offsetX: CGFloat {

        get { return self.contentOffset.x }

        set (newValue) {

            var offset = self.contentOffset
            offset.x = newValue
            self.contentOffset = offset

        }

    }


    /// 内容Y坐标
    var offsetY: CGFloat {

        get { return self.contentOffset.y }

        set (newValue) {

            var offset = self.contentOffset
            offset.y = newValue
            self.contentOffset = offset

        }

    }


    /// 内容宽度
    var contentWidth: CGFloat {

        get { return self.contentSize.width }

        set (newValue) {

            var content = self.contentSize
            content.width = newValue
            self.contentSize = content

        }

    }


    /// 内容高度
    var contentHeight: CGFloat {

        get { return self.contentSize.height }

        set (newValue) {

            var content = self.contentSize
            content.height = newValue
            self.contentSize = content

        }

    }


}
