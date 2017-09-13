# ZAScrollView
这是一个使用UIScrollView进行封装的自动循环轮播图Demo，可以实现banner图的自动循环播放，并且具有图片的点击事件，你可以将它放在APP所需要的任何地方，仅需几行代码就可以搞定。

# Installation
将ZACycleScrollView.h 和ZACycleScrollView.m 文件拖动到项目中即可

# Usage

首先引入头文件：

```
#import "ZACycleScrollView.h"
```
创建对象，并加入到self.view中

```
ZACycleScrollView * scrollView = [[ZACycleScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width / 2)];
[self.view addSubview:scrollView];
```
设置必选属性，要进行轮播显示的图片数据源

```
scrollView.imageArr = images;
```
设置可选属性

```
scrollView.pageControlPosition = ScrollViewPageControlPosition_BottomLeft;
scrollView.currentPageCircleColor = [UIColor blueColor];
scrollView.whenClickOnImage = ^( NSInteger index ){
        NSLog(@"这是第%ld张图片", index + 1);
};

```

最后，开始自动循环轮播

```
[scrollView startAutomicCycleScrollView];

```

