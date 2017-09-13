//
//  ZACycleScrollView.m
//  CustomCycleScrollView
//
//  Created by zaj on 2017/9/13.
//  Copyright © 2017年 cheng. All rights reserved.
//

#import "ZACycleScrollView.h"

@interface ZACycleScrollView() <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView * containerScrollView;
@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, strong) UIImageView * leftImageView;
@property (nonatomic, strong) UIImageView * middleImageView;
@property (nonatomic, strong) UIImageView * rightImageView;

@property (nonatomic, strong) UIPageControl * pageControl;
@property (nonatomic, strong) NSTimer * timer;

@end

@implementation ZACycleScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if ( self )
    {
        self.frame = frame;
        
        self.pageControlPosition = ScrollViewPageControlPosition_BottomCenter;
        self.currentPageCircleColor = [UIColor redColor];
        self.pageCircleColor = [UIColor whiteColor];
        self.repeatTimeInterval = 2.0;
    }
    
    return self;
}

- (void)customize
{
    self.currentIndex = 0;
    
    // 初始化scrollview
    self.containerScrollView = [[UIScrollView alloc] initWithFrame:self.frame];
    self.containerScrollView.delegate = self;
    self.containerScrollView.scrollEnabled = YES;
    self.containerScrollView.pagingEnabled = YES;
    self.containerScrollView.showsVerticalScrollIndicator = NO;
    self.containerScrollView.showsHorizontalScrollIndicator = NO;
    
    // 初始化三个固定的ImageView
    self.leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.containerScrollView.frame.size.width * 0, 0, self.containerScrollView.frame.size.width, self.containerScrollView.frame.size.height)];
    
    self.middleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.containerScrollView.frame.size.width * 1, 0, self.containerScrollView.frame.size.width, self.containerScrollView.frame.size.height)];
    
    self.rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.containerScrollView.frame.size.width * 2, 0, self.containerScrollView.frame.size.width, self.containerScrollView.frame.size.height)];
    
    [self.containerScrollView addSubview:self.leftImageView];
    [self.containerScrollView addSubview:self.middleImageView];
    [self.containerScrollView addSubview:self.rightImageView];
    [self addSubview:self.containerScrollView];
    
    // 设置scrollview的contentSize和contentOffset
    self.containerScrollView.contentSize = CGSizeMake(3 * self.containerScrollView.frame.size.width, self.containerScrollView.frame.size.height);
    self.containerScrollView.contentOffset = CGPointMake(self.containerScrollView.frame.size.width, 0);
    
    // 根据index重置ImageView的image
    [self resetScrollImagesWith:self.currentIndex];
    
    // 初始化pageControl，
    self.pageControl = [[UIPageControl alloc] init];
    [self setPageControlFrameWith:self.pageControlPosition];
    self.pageControl.currentPageIndicatorTintColor = self.currentPageCircleColor;
    self.pageControl.pageIndicatorTintColor = self.pageCircleColor;
    self.pageControl.numberOfPages = self.imageArr.count;
    self.pageControl.currentPage = 0;
    [self addSubview:self.pageControl];
    
    // 给图片添加点击手势
    UITapGestureRecognizer * recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickOnCurrentImage)];
    [self addGestureRecognizer:recognizer];
}

- (void)startAutomicCycleScrollView
{
    [self customize];
    
    [self setupTimer];
}

- (void)setPageControlFrameWith:(ScrollViewPageControlPosition)position
{
    switch (position)
    {
        case ScrollViewPageControlPosition_BottomLeft:
        {
            self.pageControl.frame = CGRectMake(0, (self.containerScrollView.frame.size.height - 30), 100, 30);
        }
            break;
        case ScrollViewPageControlPosition_BottomCenter:
        {
            self.pageControl.frame = CGRectMake((self.containerScrollView.frame.size.width - 100) / 2, (self.containerScrollView.frame.size.height - 30), 100, 30);
        }
            break;
        case ScrollViewPageControlPosition_BottomRight:
        {
            self.pageControl.frame = CGRectMake(self.containerScrollView.frame.size.width - 100, (self.containerScrollView.frame.size.height - 30), 100, 30);
        }
            break;
            
        default:
            break;
    }
}

- (void)setupTimer
{
    self.timer = [NSTimer timerWithTimeInterval:self.repeatTimeInterval target:self selector:@selector(imagesCycleScroll) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
}

- (void)imagesCycleScroll
{
    // 每隔一秒，向左滑动一个图片
    self.currentIndex = (self.currentIndex + 1) % self.imageArr.count;
    
    self.pageControl.currentPage = self.currentIndex;
    
    [self.containerScrollView setContentOffset:CGPointMake(self.containerScrollView.frame.size.width * 2, 0) animated:YES];
    
    [self resetScrollImagesWith:self.currentIndex];
    
    self.containerScrollView.contentOffset = self.containerScrollView.frame.origin;
}

- (void)resetScrollImagesWith:(NSInteger)index
{
    self.leftImageView.image = [self.imageArr objectAtIndex:(index - 1 + self.imageArr.count) % self.imageArr.count];
    self.middleImageView.image = [self.imageArr objectAtIndex:(index + self.imageArr.count) % self.imageArr.count];
    self.rightImageView.image = [self.imageArr objectAtIndex:(index + 1 + self.imageArr.count) % self.imageArr.count];
}

- (void)clickOnCurrentImage
{
    if ( self.whenClickOnImage )
    {
        self.whenClickOnImage(self.currentIndex);
    }
}

#pragma mark -- scrollviewdelegate function

//当用户手动个轮播时 关闭定时器
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.timer invalidate];
    self.timer = nil;
}

//当用户手指停止滑动图片时 启动定时器
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self setupTimer];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;
    
    if ( offset.x == 0 ) // 向右滑动
    {
        self.currentIndex = (self.currentIndex + self.imageArr.count - 1) % self.imageArr.count;
    }
    else if ( offset.x == 2 * self.containerScrollView.frame.size.width ) // 向左滑动
    {
        self.currentIndex = (self.currentIndex + 1) % self.imageArr.count;
    }
    else
    {
        return;
    }
    
    self.pageControl.currentPage = self.currentIndex;
    
    [self resetScrollImagesWith:self.currentIndex];
    
    self.containerScrollView.contentOffset = CGPointMake(self.containerScrollView.frame.size.width, 0);
}


@end
