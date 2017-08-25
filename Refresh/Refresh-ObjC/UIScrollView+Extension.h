//
//  UIScrollView+Extension.h
//  Refresh
//
//  Created by lu on 16/5/16.
//  Copyright © 2016年 --. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LRefresh;

@interface UIScrollView (Extension)

// 给scrollView添加上下拉控件
@property (nonatomic, strong) LRefresh *header;
@property (nonatomic, strong) LRefresh *footer;

@end
