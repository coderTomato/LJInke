//
//  IndexViewController.m
//  LJInke
//
//  Created by Robin on 17/11/20.
//  Copyright © 2017年 Robin. All rights reserved.
//

#import "IndexViewController.h"
#import "LiveViewController.h"
#import "LJTittleButton.h"


@interface IndexViewController ()<UIScrollViewDelegate>

/** scrollView*/
@property (weak, nonatomic) UIScrollView *scrollView;
/** 下划线*/
@property (weak, nonatomic) UIView *underLineView;
/** 选中的按钮*/
@property (weak, nonatomic) LJTittleButton *selectedButton;

@end

@implementation IndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航条
    [self setupNavBar];
    [self setupChildVc];
    //设置scrollView
    [self setupScrollView];
    [self setupTitleView];
    [self addChildVcView];
}

- (void)setupNavBar
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"title_button_search" highImage:@"title_button_search" target:self action:@selector(leftButtonClick)];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"title_button_more" highImage:@"title_button_more" target:nil action:nil];
}

- (void)setupTitleView
{
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW - 100, 40)];
    self.navigationItem.titleView = titleView;
    // 添加标题
    NSArray *titles = @[@"推荐",@"小视频", @"发现"];
    NSUInteger count = titles.count;
    CGFloat titleButtonH = titleView.ty_height;
    CGFloat titleButtonW = titleView.ty_width / count;
    for(NSUInteger i = 0; i < count; i++)
    {
        NSString *titleStr = titles[i];
        //创建
        LJTittleButton *button = [[LJTittleButton alloc] initWithFrame:CGRectMake(i * titleButtonW, 0, titleButtonW, titleButtonH)];
        // 设置数据
        [button setTitle:titleStr forState:UIControlStateNormal];
        button.tag = i;
        [button addTarget:self action:@selector(titleButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [titleView addSubview:button];
    }
    //取出第一个按钮
    LJTittleButton *firstBtn = titleView.subviews.firstObject;
    // 底部的指示器
    [firstBtn.titleLabel sizeToFit];
    
    UIView *underLineView = [[UIView alloc] initWithFrame:CGRectMake(0, firstBtn.ty_bottom - 2, firstBtn.titleLabel.ty_width, 2)];
    underLineView.backgroundColor = [firstBtn titleColorForState:UIControlStateSelected];
    [titleView addSubview:underLineView];
    
    self.underLineView = underLineView;
    self.underLineView.ty_centerX = firstBtn.ty_centerX;
    
    firstBtn.selected = YES;
    self.selectedButton = firstBtn;
}

- (void)setupScrollView
{
    NSInteger count = self.childViewControllers.count;
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = LJColor(206, 206, 206);
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.frame = self.view.bounds;
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(ScreenW *count, 0);
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
}

- (void)setupChildVc
{
    LiveViewController *liveVc = [[LiveViewController alloc] init];
    [self addChildViewController:liveVc];
    
    UIViewController *littleVc = [[UIViewController alloc] init];
    [self addChildViewController:littleVc];
    
    UIViewController *findVc = [[UIViewController alloc] init];
    [self addChildViewController:findVc];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 子控制器的索引
    NSUInteger index = self.scrollView.contentOffset.x / self.scrollView.ty_width;
    LJTittleButton *btn = self.navigationItem.titleView.subviews[index];
    [self titleButtonClicked:btn];
    [self addChildVcView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self addChildVcView];
}

- (void)addChildVcView
{
    // 子控制器的索引
    NSUInteger index = self.scrollView.contentOffset.x / self.scrollView.ty_width;
    // 取出子控制器
    UIViewController *childVc = self.childViewControllers[index];
    if (childVc.isViewLoaded)  return;
    childVc.view.backgroundColor = LJColor(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255));
    childVc.view.frame = self.scrollView.bounds;
    [self.scrollView addSubview:childVc.view];
}

- (void)leftButtonClick
{
    DLog(@"leftButtonClick");
}

- (void)titleButtonClicked:(LJTittleButton *)sender
{
    self.selectedButton.selected = NO;
    sender.selected = YES;
    self.selectedButton = sender;
    [UIView animateWithDuration:0.25 animations:^{
        self.underLineView.ty_centerX = sender.ty_centerX;
    }];
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = sender.tag * ScreenW;
    [self.scrollView setContentOffset:offset animated:YES];
}


@end
