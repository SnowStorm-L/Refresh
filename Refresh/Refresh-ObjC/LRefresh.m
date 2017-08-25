//
//  Refresh.m
//  Refresh
//
//  Created by lu on 16/5/15.
//  Copyright © 2016年 --. All rights reserved.
//

#import "LRefresh.h"
#import "UIView+Frame.h"

#define RefreshViewHeight 44

#define RefreshKeyPathContentOffset @"contentOffset"

#define RefreshKeyPathContentInset @"contentInset"

#define RefreshKeyPathContentSize    @"contentSize"

#define RefreshKeyPathPanState  @"state"

#define RefreshAnimationDuration  0.25

#define HeaderRefreshNormalStateDescription          @"下拉刷新"
#define HeaderRefreshWillRefreshingStateDescription  @"松手即将刷新"
#define FooterRefreshNormalStateDescription          @"上拉刷新"
#define FooterRefreshWillRefreshingStateDescription  @"松手即将刷新"
#define RefreshEndingWithNoMoreDataStateDescription      @"没有更多了"

@interface LRefresh ()

@property(nonatomic,strong)UIScrollView *scrollView;

@property(nonatomic,assign)UIEdgeInsets originalContentInset;

//偏移
@property(nonatomic,assign)CGFloat TopOffset;
@property(nonatomic,assign)CGFloat lastBottomOffset;

@property(nonatomic,strong)UIView *headerView;
@property(nonatomic,strong)UIView *footerView;


@property(nonatomic,strong)UIActivityIndicatorView *activityHeaderView;
@property(nonatomic,strong)UIActivityIndicatorView *activityFooterView;


@property(nonatomic,strong)UILabel *headerLabel;
@property(nonatomic,strong)UILabel *footerLabel;


@end


@implementation LRefresh

+(instancetype)initHeaderWithScrollView:(UIScrollView *)scrollView headerRefreshingBlock:(RefreshingBlock)block
{
    return [[self alloc]initHeaderWithScrollView:scrollView headerRefreshingBlock:block];
}

-(instancetype)initHeaderWithScrollView:(UIScrollView *)scrollView headerRefreshingBlock:(RefreshingBlock)block
{
    if (self=[super init]) {
        [self create:scrollView];
        [self createHeaderRefresh:block];
    }
    return self;
}

+(instancetype)initFooterWithScrollView:(UIScrollView *)scrollView footerRefreshingBlock:(RefreshingBlock)block
{
    return [[self alloc]initFooterWithScrollView:scrollView footerRefreshingBlock:block];
}

-(instancetype)initFooterWithScrollView:(UIScrollView *)scrollView footerRefreshingBlock:(RefreshingBlock)block
{
    if (self=[super init]) {
        [self create:scrollView];
        [self createFooterRefresh:block];
    }
    return self;
}


#pragma mark - 控件设置
-(void)create:(UIScrollView *)scrollView
{
    if (scrollView==nil) return;
    self.scrollView = scrollView;
    // 旧的父控件移除监听
    [self removeObservers];
    
    self.width = scrollView.width;
    self.x = 0;
    
    // 设置永远支持垂直弹簧效果
    _scrollView.alwaysBounceVertical = YES;
    // 记录UIScrollView最开始的contentInset
    _originalContentInset = self.scrollView.contentInset;
    
    // 添加监听
    [self addObservers];

}

-(void)createHeaderRefresh:(RefreshingBlock)block
{
    if (self.scrollView==nil) return;
    
    UIView *headerView = [[UIView alloc] initWithFrame:self.bounds];
    headerView.backgroundColor = [UIColor clearColor];
    self.headerView = headerView;
    UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activity.hidesWhenStopped = NO;
    activity.hidden = YES;
   
    self.activityHeaderView = activity;
    [headerView addSubview:activity];
    
    UILabel *headerLabel = [[UILabel alloc] init];
    headerLabel.font = [UIFont systemFontOfSize:14.0f];
    headerLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    headerLabel.textAlignment = NSTextAlignmentCenter;
    headerLabel.text = HeaderRefreshNormalStateDescription;
    self.headerLabel = headerLabel;
    [headerView addSubview:headerLabel];
    
    [self addSubview:headerView];
    [self.scrollView addSubview:self];
    
    self.headerRefreshingBlock = block;
    self.refreshType = HeaderRefresh;
    self.headerRefreshState = RefreshStateNormal;
    
}

-(void)createFooterRefresh:(RefreshingBlock)block
{
    if (self.scrollView == nil) return;
    UIView *footerView = [[UIView alloc] initWithFrame:self.bounds];
    footerView.backgroundColor = [UIColor clearColor];
    self.footerView = footerView;
    UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activity.hidesWhenStopped = NO;
    activity.hidden = YES;
   
    self.activityFooterView = activity;
    [footerView addSubview:activity];
    
    UILabel *footerLabel = [[UILabel alloc] init];
    footerLabel.font = [UIFont systemFontOfSize:14.0f];
    footerLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    footerLabel.textAlignment = NSTextAlignmentCenter;
    footerLabel.text = HeaderRefreshNormalStateDescription;
    self.footerLabel = footerLabel;
    [footerView addSubview:footerLabel];
    [self addSubview:footerView];
    [self.scrollView addSubview:self];
    
    self.footerRefreshingBlock = block;
    self.refreshType = FooterRefresh;
    self.footerRefreshState =RefreshStateNormal;
}


#pragma mark - 状态设置

-(void)setHeaderRefreshState:(RefreshState)headerRefreshState
{
    RefreshState oldState=self.headerRefreshState;
    if (headerRefreshState==oldState) return;
    _headerRefreshState=headerRefreshState;
    
    switch (headerRefreshState) {
        case RefreshStateNormal:
        case RefreshStateWillRefreshing:
        {
            self.headerLabel.hidden=NO;
            self.activityHeaderView.hidden=YES;
            if (headerRefreshState==RefreshStateNormal) {
                self.headerLabel.text=HeaderRefreshNormalStateDescription;
            }
            else if (headerRefreshState==RefreshStateWillRefreshing)
            {
                self.headerLabel.text=HeaderRefreshWillRefreshingStateDescription;
            }
            if (oldState!=RefreshStateRefreshing) return;
            
            //恢复inset和offset
            [UIView animateWithDuration:RefreshAnimationDuration animations:^{
                self.scrollView.insetTop+=self.TopOffset;
            }];
        }
            break;
        case RefreshStateRefreshing:
        {
            self.headerLabel.hidden=YES;
            self.activityHeaderView.hidden=NO;
            [UIView animateWithDuration:RefreshAnimationDuration animations:^{
               //增加滚动区域
                CGFloat top=self.originalContentInset.top+self.height;
                self.scrollView.insetTop=top;
                
                //设置滚动区域
                self.scrollView.offsetY=-top;
            }completion:^(BOOL finished) {
                if (self.headerRefreshingBlock) {
                    self.headerRefreshingBlock();
                }
            }];
        }
            break;
            
       case RefreshStateNoticeNoMoreData:
    
           default:
            break;
    }
}

-(void)setFooterRefreshState:(RefreshState)footerRefreshState
{
    RefreshState oldState=self.footerRefreshState;
    if (footerRefreshState==oldState) return;
    _footerRefreshState=footerRefreshState;
    
    switch (footerRefreshState) {
        case RefreshStateNormal:
            case RefreshStateWillRefreshing:
            case RefreshStateNoticeNoMoreData:
        {
            self.footerLabel.hidden=NO;
            self.activityFooterView.hidden=YES;
            if (footerRefreshState==RefreshStateNormal) {
                self.footerLabel.text=FooterRefreshNormalStateDescription;
            }
            else if (footerRefreshState==RefreshStateWillRefreshing)
            {
                self.footerLabel.text=FooterRefreshWillRefreshingStateDescription;
            }
            else{
                if (self.refreshEndingWithNoMoreData.length>0) {
                    self.footerLabel.text=self.refreshEndingWithNoMoreData;
                }
                else{
                    self.footerLabel.text=RefreshEndingWithNoMoreDataStateDescription;
                }
            }
            if (oldState!=RefreshStateRefreshing)return;
            //刷新完成
            if (RefreshStateRefreshing==oldState) {
                [UIView animateWithDuration:RefreshAnimationDuration animations:^{
                    self.scrollView.insetBottom-=self.lastBottomOffset;
                }];
            }
        }
            break;
       case RefreshStateRefreshing:
        {
            self.footerLabel.hidden=YES;
            self.activityFooterView.hidden=NO;
            [UIView animateWithDuration:RefreshAnimationDuration animations:^{
                CGFloat bottom=self.height+self.originalContentInset.bottom;
                CGFloat OffsetHeight=[self heightForContentBreakView];
                
                if (OffsetHeight < 0) { // 如果内容高度小于view的高度
                    bottom -= OffsetHeight;
                }
                self.lastBottomOffset = bottom - self.scrollView.insetBottom;
                self.scrollView.insetBottom = bottom;
                self.scrollView.offsetY = [self happenOffsetY] + self.height;
                
            }completion:^(BOOL finished) {
                if (self.footerRefreshingBlock) {
                    self.footerRefreshingBlock();
                }
            }];
        }
            
            
        default:
            break;
    }
}

#pragma mark - 布局
-(void)layoutSubviews
{
    [super layoutSubviews];
    if (self.headerView) {
        self.y=-RefreshViewHeight;
        self.height=RefreshViewHeight;
        self.headerView.frame=self.bounds;
        self.activityHeaderView.center=self.headerView.center;
        self.headerLabel.frame=self.headerView.bounds;
    }
    
    if (self.footerView) {
        self.y=self.scrollView.contentHeight>self.scrollView.height ? self.scrollView.contentHeight+self.scrollView.insetBottom : self.scrollView.height+self.scrollView.insetBottom;
        self.height=RefreshViewHeight;
        self.footerView.frame=self.bounds;
        self.activityFooterView.center=self.footerView.center;
        self.footerLabel.frame=self.footerView.bounds;
    }
}

#pragma mark - KVO监听
-(void)addObservers
{
    NSKeyValueObservingOptions options=NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld;
    [self.scrollView addObserver:self forKeyPath:RefreshKeyPathContentOffset options:options context:nil];
    [self.scrollView addObserver:self forKeyPath:RefreshKeyPathContentSize options:options context:nil];
}

-(void)removeObservers
{
    [self.superview removeObserver:self forKeyPath:RefreshKeyPathContentSize];
    [self.superview removeObserver:self forKeyPath:RefreshKeyPathContentOffset];
}

#pragma mark - KVO方法
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    // 偏移位置变化
    if ([keyPath isEqualToString:RefreshKeyPathContentOffset]) {
        [self scrollViewContentOffsetDidChange:change];
    }
    // contentSize变化
    else if ([keyPath isEqualToString:RefreshKeyPathContentSize])
    {
        [self scrollViewContentSizeDidChange:change];
    }
}

-(void)scrollViewContentOffsetDidChange:(NSDictionary *)change{
    if (self.refreshType==FooterRefresh){
        if (self.footerRefreshState==RefreshStateRefreshing) return;
        if (self.footerRefreshState==RefreshStateNoticeNoMoreData)return;
    }
    else if (self.refreshType==HeaderRefresh)
    {
        // 再刷新的refreshing状态
        if (self.headerRefreshState==RefreshStateRefreshing) {
            if (self.window==nil) return;
            // sectionheader停留解决
            CGFloat insetTop=-self.scrollView.offsetY>_originalContentInset.top? -self.scrollView.offsetY :_originalContentInset.top;
            
            insetTop=insetTop>self.height+_originalContentInset.top ? self.height+_originalContentInset.top : insetTop;
            self.scrollView.insetTop=insetTop;
            self.TopOffset=_originalContentInset.top-insetTop;
            return;
        }
    }
    // 当前的contentOffset
    CGFloat offsetY=self.scrollView.offsetY; CGFloat happenOffsetY = 0;
    CGFloat normal2pullingOffsetY = 0;
    
    if(self.refreshType == HeaderRefresh){
        // 头部控件刚好出现的offsetY
        happenOffsetY = - self.originalContentInset.top;
        // 如果是向上滚动到看不见头部控件，直接返回
        if (offsetY > happenOffsetY) return;
        normal2pullingOffsetY = happenOffsetY - self.height;
    }else if(self.refreshType == FooterRefresh){
        // 尾部控件刚好出现的offsetY
        happenOffsetY = [self happenOffsetY];
        // 如果是向下滚动到看不见尾部控件，直接返回
        if (offsetY <= happenOffsetY) return;
        normal2pullingOffsetY = happenOffsetY + self.height;
    }
    
    
    if (self.scrollView.isDragging) { // 如果正在拖拽
        if (self.refreshType == HeaderRefresh) {
            if (self.headerRefreshState == RefreshStateNormal) {
                if (offsetY < normal2pullingOffsetY) {
                    // 转为即将刷新状态
                    self.headerRefreshState = RefreshStateWillRefreshing;
                }
            }else if (self.headerRefreshState == RefreshStateWillRefreshing){
                if (offsetY >= normal2pullingOffsetY) {
                    // 转为普通状态
                    self.headerRefreshState = RefreshStateNormal;
                }
            }
        }
        
        if (self.refreshType == FooterRefresh) {
            if (self.footerRefreshState == RefreshStateNormal) {
                if (offsetY > normal2pullingOffsetY) {
                    // 转为即将刷新状态
                    self.footerRefreshState = RefreshStateWillRefreshing;
                }
            }else if (self.footerRefreshState == RefreshStateWillRefreshing ) {
                if (offsetY <= normal2pullingOffsetY) {
                    // 转为普通状态
                    self.footerRefreshState = RefreshStateNormal;
                }
            }
        }
    }else if (self.footerRefreshState == RefreshStateWillRefreshing
              || self.headerRefreshState == RefreshStateWillRefreshing) {// 即将刷新 && 手松开
        
        if (self.refreshType == HeaderRefresh) {
            // 开始刷新
            [self beginHeaderRefreshing];
        }else if (self.refreshType == FooterRefresh) {
            [self beginFooterRefreshing];
        }
    }

    
}

#pragma mark - 刷新状态变换
- (void)beginHeaderRefreshing{
    self.headerRefreshState = RefreshStateRefreshing;
    [self.activityHeaderView startAnimating];
}
- (void)beginFooterRefreshing{
    self.footerRefreshState = RefreshStateRefreshing;
    [self.activityFooterView startAnimating];
}

- (void)endHeaderRefreshing{
    self.headerRefreshState = RefreshStateNormal;
    if ([self.activityHeaderView isAnimating]) {
        [self.activityHeaderView stopAnimating];
    }
}
- (void)endFooterRefreshing{
    self.footerRefreshState = RefreshStateNormal;
    if ([self.activityFooterView isAnimating]) {
        [self.activityFooterView stopAnimating];
    }
}

-(void)refreshEndingWithNoMoreDate{
    [self refreshEndingWithNoMoreDate:nil];
}
-(void)refreshEndingWithNoMoreDate:(NSString *)noMoreData
{
    self.refreshEndingWithNoMoreData=noMoreData;
    self.footerRefreshState=RefreshStateNoticeNoMoreData;
    if ([self.activityFooterView isAnimating]) {
        [self.activityFooterView stopAnimating];
    }
}
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change{
    // 内容的高度
    CGFloat contentHeight = self.scrollView.contentHeight;
    // 表格的高度
    CGFloat scrollHeight = self.scrollView.height - self.originalContentInset.top - self.originalContentInset.bottom;
    // 设置位置和尺寸
    if (self.refreshType == FooterRefresh) {
        self.y = MAX(contentHeight, scrollHeight);
    }
}

#pragma mark 获得scrollView的内容 超出 view 的高度
- (CGFloat)heightForContentBreakView
{
    CGFloat h = self.scrollView.frame.size.height - self.originalContentInset.bottom - self.originalContentInset.top;
    return self.scrollView.contentSize.height - h;
}

#pragma mark 刚好看到上拉刷新控件时的contentOffset.y
- (CGFloat)happenOffsetY
{
    CGFloat deltaH = [self heightForContentBreakView];
    if (deltaH > 0) { // contentSize 超出scrollView的高度
        return deltaH - self.originalContentInset.top;
    } else { // contentSize 没有超出scrollView的高度
        return - self.originalContentInset.top;
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
