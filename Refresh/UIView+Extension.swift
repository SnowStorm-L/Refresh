
import UIKit

extension UIView {

    /// X坐标
    var x: CGFloat {

        get { return self.frame.origin.x }

        set (newValue) {

            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame

        }

    }


    /// Y坐标
    var y: CGFloat {

        get { return self.frame.origin.y }

        set (newValue) {

            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
            
        }
        
    }

    /// 宽
    var width: CGFloat {

        get { return self.frame.size.width }

        set (newValue) {

        var frame = self.frame
            frame.size.width = newValue
        self.frame = frame

        }

    }

    /// 高
    var height: CGFloat {

        get { return self.frame.size.height }

        set (newValue)  {

            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame

        }

    }

    /// View大小
    var size: CGSize {
        
        get { return CGSize(width: width, height: height) }

        set (newValue) {

            var frame = self.frame
            frame.size = newValue
            self.frame = frame

        }
        
    }


    /// View中心X坐标
    var centerX: CGFloat {

        get { return self.center.x }

        set (newValue) {

            var center = self.center
            center.x = newValue
            self.center = center

        }

    }


    /// View中心Y坐标
    var centerY: CGFloat {

        get { return self.center.y }

        set (newValue) {

            var center = self.center
            center.y = newValue
            self.center = center

        }

    }

    /// 添加毛玻璃
    ///
    /// - Parameter stype: 毛玻璃样式
    public func addBlurEffect(_ stype:UIBlurEffectStyle) {

        let blurEffect = UIBlurEffect(style: stype)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.frame = self.bounds
        self.addSubview(visualEffectView)

    }

}
