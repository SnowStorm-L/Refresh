//
//  FootRefresh.h
//  Refresh
//
//  Created by lu on 16/5/16.
//  Copyright © 2016年 --. All rights reserved.
//

#import "LRefresh.h"

@interface FootRefresh : LRefresh

+ (instancetype)createFooterWithRefreshingBlock:(RefreshingBlock)refreshingBlock scrollView:(UIScrollView *)scrollView;

@end
