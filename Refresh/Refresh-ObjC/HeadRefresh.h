//
//  HeadRefresh.h
//  Refresh
//
//  Created by lu on 16/5/16.
//  Copyright © 2016年 --. All rights reserved.
//

#import "LRefresh.h"

@interface HeadRefresh : LRefresh

+ (instancetype)createHeaderWithRefreshingBlock:(RefreshingBlock)refreshingBlock scrollView:(UIScrollView *)scrollView;


@end
