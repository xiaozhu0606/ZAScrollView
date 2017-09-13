//
//  ZACycleScrollView.h
//  CustomCycleScrollView
//
//  Created by zaj on 2017/9/13.
//  Copyright © 2017年 cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM( NSUInteger ,ScrollViewPageControlPosition ) {
    
    ScrollViewPageControlPosition_BottomLeft = 0,
    ScrollViewPageControlPosition_BottomCenter = 1,  ////默认在底部中间
    ScrollViewPageControlPosition_BottomRight = 2,
    
};

@interface ZACycleScrollView : UIView

// required, 设置图片数据源
@property (nonatomic, strong) NSArray * imageArr;

// optional, 设置pageControl的位置，默认底部中间
@property (nonatomic, assign) ScrollViewPageControlPosition pageControlPosition;

// optional, 设置当前页的pageControl的颜色，默认红色
@property (nonatomic, strong) UIColor * currentPageCircleColor;

// optional, 设置其他页的pageControl的颜色，默认白色
@property (nonatomic, strong) UIColor * pageCircleColor;

// optional, 设置定时器的时间间隔，默认2秒
@property (nonatomic, assign) NSTimeInterval  repeatTimeInterval;

// optional, 图片的点击事件, block回调
@property (nonatomic, copy) void(^whenClickOnImage)(NSInteger currentIndex);

// required 启动自动循环轮播图
- (void)startAutomicCycleScrollView;

@end
