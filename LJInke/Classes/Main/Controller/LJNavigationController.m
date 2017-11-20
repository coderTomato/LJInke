//
//  LJNavigationController.m
//  LJInke
//
//  Created by Robin on 17/11/20.
//  Copyright © 2017年 Robin. All rights reserved.
//

#import "LJNavigationController.h"

@interface LJNavigationController ()

@end

@implementation LJNavigationController

+ (void)load
{
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedIn:self, nil];
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:18.0];
    attrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [navBar setTitleTextAttributes:attrs];
    
    // 设置导航条背景图片
    [navBar setBackgroundImage:[UIImage imageNamed:@"global_tittle"] forBarMetrics:UIBarMetricsDefault];
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}



@end
