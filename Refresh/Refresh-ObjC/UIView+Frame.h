//
//  UIView+Frame.h
//  Refresh
//
//  Created by lu on 16/5/15.
//  Copyright © 2016年 --. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

@property(nonatomic,assign)CGFloat x;

@property(nonatomic,assign)CGFloat y;

@property(nonatomic,assign)CGFloat width;

@property(nonatomic,assign)CGFloat height;

@property(nonatomic,assign)CGFloat centerX;

@property(nonatomic,assign)CGFloat centerY;

@property(nonatomic,assign)CGSize  size;

@property(nonatomic,assign)CGPoint origin;

@end

@interface UIScrollView (Frame)

@property(nonatomic,assign)CGFloat insetTop;

@property(nonatomic,assign)CGFloat insetBottom;

@property(nonatomic,assign)CGFloat insetLeft;

@property(nonatomic,assign)CGFloat insetRight;

@property(nonatomic,assign)CGFloat offsetX;

@property(nonatomic,assign)CGFloat offsetY;

@property(nonatomic,assign)CGFloat contentWidth;

@property(nonatomic,assign)CGFloat contentHeight;

@end




