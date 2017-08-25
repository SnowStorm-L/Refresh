//
//  HeadRefresh.m
//  Refresh
//
//  Created by lu on 16/5/16.
//  Copyright © 2016年 --. All rights reserved.
//

#import "HeadRefresh.h"

@implementation HeadRefresh

+(instancetype)createHeaderWithRefreshingBlock:(RefreshingBlock)refreshingBlock scrollView:(UIScrollView *)scrollView{


    return [self initHeaderWithScrollView:scrollView headerRefreshingBlock:refreshingBlock];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
