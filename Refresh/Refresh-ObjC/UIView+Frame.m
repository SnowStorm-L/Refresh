//
//  UIView+Frame.m
//  Refresh
//
//  Created by lu on 16/5/15.
//  Copyright © 2016年 --. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

-(void)setX:(CGFloat)x
{
    CGRect frame=self.frame;
    frame.origin.x=x;
    self.frame=frame;
}

-(CGFloat)x
{
    return self.frame.origin.x;
}

-(void)setY:(CGFloat)y
{
    CGRect frame=self.frame;
    frame.origin.y=y;
    self.frame=frame;
}

-(CGFloat)y
{
    return self.frame.origin.y;
}

-(void)setCenterX:(CGFloat)centerX
{
    CGPoint center=self.center;
    center.x=centerX;
    self.center=center;
}

-(CGFloat)centerX
{
    return self.center.x;
}

-(void)setCenterY:(CGFloat)centerY
{
    CGPoint center=self.center;
    center.y=centerY;
    self.center=center;
}

-(CGFloat)centerY
{
    return self.center.y;
}

-(void)setWidth:(CGFloat)width
{
    CGRect frame=self.frame;
    frame.size.width=width;
    self.frame=frame;
}

-(CGFloat)width
{
    return self.frame.size.width;
}

-(void)setHeight:(CGFloat)height
{
    CGRect frame=self.frame;
    frame.size.height=height;
    self.frame=frame;
    
}

-(CGFloat)height
{
    return self.frame.size.height;
}

-(void)setSize:(CGSize)size
{
    CGRect frame=self.frame;
    frame.size=size;
    self.frame=frame;
}

-(CGSize)size
{
    return self.frame.size;
}

-(void)setOrigin:(CGPoint)origin
{
    CGRect frame=self.frame;
    frame.origin=origin;
    self.frame=frame;
    
}

-(CGPoint)origin
{
    return self.frame.origin;
}

@end

@implementation UIScrollView (Frame)

-(void)setInsetTop:(CGFloat)insetTop
{
    UIEdgeInsets inset=self.contentInset;
    inset.top=insetTop;
    self.contentInset=inset;
}

-(CGFloat)insetTop
{
    return self.contentInset.top;
}

-(void)setInsetBottom:(CGFloat)insetBottom
{
    UIEdgeInsets inset=self.contentInset;
    inset.bottom=insetBottom;
    self.contentInset=inset;
}

-(CGFloat)insetBottom
{
    return self.contentInset.bottom;
}

-(void)setInsetLeft:(CGFloat)insetLeft
{
    UIEdgeInsets inset=self.contentInset;
    inset.left=insetLeft;
    self.contentInset=inset;
}

-(CGFloat)insetLeft
{
    return self.contentInset.left;
}

-(void)setInsetRight:(CGFloat)insetRight
{
    UIEdgeInsets inset=self.contentInset;
    
    inset.right=insetRight;
    
    self.contentInset=inset;
}

-(CGFloat)insetRight
{
    return self.contentInset.right;
}

-(void)setOffsetX:(CGFloat)offsetX
{
    CGPoint offset=self.contentOffset;
    offset.x=offsetX;
    self.contentOffset=offset;
}

-(CGFloat)offsetX
{
    return self.contentOffset.x;
}

-(void)setOffsetY:(CGFloat)offsetY
{
    CGPoint offset=self.contentOffset;
    offset.y=offsetY;
    self.contentOffset=offset;
}

-(CGFloat)offsetY
{
    return self.contentOffset.y;
}

-(void)setContentWidth:(CGFloat)contentWidth
{
    CGSize size=self.contentSize;
    size.width=contentWidth;
    self.contentSize=size;
}

-(CGFloat)contentWidth
{
    return self.contentSize.width;
}

-(void)setContentHeight:(CGFloat)contentHeight
{
    CGSize size=self.contentSize;
    size.height=contentHeight;
    self.contentSize=size;
    
}

-(CGFloat)contentHeight
{
    return self.contentSize.height;
}


@end