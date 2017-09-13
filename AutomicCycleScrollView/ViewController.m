//
//  ViewController.m
//  AutomicCycleScrollView
//
//  Created by zaj on 2017/9/13.
//
//

#import "ViewController.h"
#import "ZACycleScrollView.h"

@interface ViewController ()

@property (nonatomic, strong)ZACycleScrollView *scrollView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupScrollView];
}

- (void)setupScrollView
{
    NSMutableArray * images = [[NSMutableArray alloc] init];
    
    for ( NSInteger i = 1; i <= 6; ++i )
    {
        UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"image%ld.jpg",(long)i]];
        [images addObject:image];
    }
    
    self.scrollView = [[ZACycleScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width / 2)];
    
    [self.view addSubview:self.scrollView];
    
    self.scrollView.imageArr = images;
    
//    self.scrollView.pageControlPosition = ScrollViewPageControlPosition_BottomLeft;
//    
//    self.scrollView.currentPageCircleColor = [UIColor blueColor];
//    
//    self.scrollView.whenClickOnImage = ^( NSInteger index ){
//        NSLog(@"这是第%ld张图片", index + 1);
//    };
    
    [self.scrollView startAutomicCycleScrollView];
}


@end
