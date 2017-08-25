//
//  Refresh.h
//  Refresh
//
//  Created by lu on 16/5/15.
//  Copyright © 2016年 --. All rights reserved.
//

#import <UIKit/UIKit.h>

//头部,底部刷新两种类型
typedef NS_ENUM(NSUInteger,RefreshType) {
    FooterRefresh = 0 ,
    HeaderRefresh ,
};

//刷新状态
typedef NS_ENUM(NSUInteger,RefreshState){
    RefreshStateNormal=0,
    RefreshStateWillRefreshing,
    RefreshStateRefreshing,
    RefreshStateNoticeNoMoreData,
};

//进入刷新状态的回调
typedef void(^RefreshingBlock)();

@interface LRefresh : UIView

@property(nonatomic,copy)RefreshingBlock footerRefreshingBlock;

@property(nonatomic,copy)RefreshingBlock headerRefreshingBlock;

@property(nonatomic,assign)RefreshType refreshType;

@property(nonatomic,assign)RefreshState headerRefreshState;

@property(nonatomic,assign)RefreshState footerRefreshState;

@property(nonatomic,strong)NSString*refreshEndingWithNoMoreData;

/**
 *  下拉刷新初始化
 */

-(instancetype)initHeaderWithScrollView:(UIScrollView *)scrollView headerRefreshingBlock:(RefreshingBlock)block;

+(instancetype)initHeaderWithScrollView:(UIScrollView *)scrollView headerRefreshingBlock:(RefreshingBlock)block;

/**
 *  上提更多初始化
 */

-(instancetype)initFooterWithScrollView:(UIScrollView *)scrollView footerRefreshingBlock:(RefreshingBlock)block;

+(instancetype)initFooterWithScrollView:(UIScrollView *)scrollView footerRefreshingBlock:(RefreshingBlock)block;


- (void)beginHeaderRefreshing;
- (void)beginFooterRefreshing;

- (void)endHeaderRefreshing;
- (void)endFooterRefreshing;

-(void)refreshEndingWithNoMoreDate;
-(void)refreshEndingWithNoMoreDate:(NSString *)noMoreData;

/** 当scrollView的contentOffset发生改变的时候调用 */
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change;
/** 当scrollView的contentSize发生改变的时候调用 */
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change;



@end
