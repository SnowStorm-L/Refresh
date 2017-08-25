//
//  UIScrollView+Extension.m
//  Refresh
//
//  Created by lu on 16/5/16.
//  Copyright © 2016年 --. All rights reserved.
//

#import "UIScrollView+Extension.h"
#import "LRefresh.h"
#import <objc/runtime.h>

@implementation UIScrollView (Extension)
#pragma mark - header
static const char RefreshExtensionHeaderKey = '\0';

-(void)setHeader:(LRefresh *)header
{
    if (header != self.header) {
        // 删除旧的，添加新的
        [self.header removeFromSuperview];
        [self insertSubview:header atIndex:0];
       
        
        // 存储新的
        [self willChangeValueForKey:@"header"]; // KVO
        objc_setAssociatedObject(self, &RefreshExtensionHeaderKey,
                                 header, OBJC_ASSOCIATION_ASSIGN);
        [self didChangeValueForKey:@"header"]; // KVO
    }
}

-(LRefresh *)header
{
    return objc_getAssociatedObject(self, &RefreshExtensionHeaderKey);
}

#pragma mark - footer
static const char RefreshExtensionFooterKey = '\0';

-(void)setFooter:(LRefresh *)footer
{

    if (footer != self.footer) {
        // 删除旧的，添加新的
        [self.footer removeFromSuperview];
        [self insertSubview:footer atIndex:0];
        
        // 存储新的
        [self willChangeValueForKey:@"afooter"]; // KVO
        objc_setAssociatedObject(self, &RefreshExtensionFooterKey,
                                 footer, OBJC_ASSOCIATION_ASSIGN);
        [self didChangeValueForKey:@"footer"]; // KVO
    }
}

-(LRefresh *)footer
{
    return objc_getAssociatedObject(self, &RefreshExtensionFooterKey);
}

@end


