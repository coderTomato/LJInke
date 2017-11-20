//
//  LJTabBarController.m
//  LJInke
//
//  Created by Robin on 17/11/20.
//  Copyright © 2017年 Robin. All rights reserved.
//

#import "LJTabBarController.h"
#import "LJTabBar.h"
#import "LJNavigationController.h"
#import "IndexViewController.h"
#import "NearbyViewController.h"
#import "FollowViewController.h"
#import "MeViewController.h"
#import "LJCameraView.h"
#import "LJLaunchViewController.h"

@interface LJTabBarController ()<UITabBarDelegate,LJTabBarDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) UIImagePickerController *imagePickerController;


@end

@implementation LJTabBarController

/**** 设置所有UITabBarItem的文字属性 ****/
+ (void)load
{
    // 获取哪个类中UITabBarItem
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedIn:self, nil];
    NSMutableDictionary *selectDict = [NSMutableDictionary dictionary];
    selectDict[NSForegroundColorAttributeName] = LJColor(39, 188, 218);
    [item setTitleTextAttributes:selectDict forState:UIControlStateSelected];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    /** 添加子控制器*/
    [self setupChildViewControllers];
    /** 更换TabBar*/
    [self setupTabBar];
}

- (void)setupChildViewControllers
{
    [self setupOneController:[[IndexViewController alloc] init] image:@"tab_live" title:@"首页"];
    [self setupOneController:[[NearbyViewController alloc] init] image:@"tab_near" title:@"附近"];
    [self setupOneController:[[FollowViewController alloc] init] image:@"tab_following" title:@"关注"];
    [self setupOneController:[[MeViewController alloc] init] image:@"tab_me" title:@"我"];
}

- (void)setupTabBar
{
    LJTabBar *tabBar = [[LJTabBar alloc] init];
    tabBar.delegate = self;
    [self setValue:[[LJTabBar alloc] init] forKeyPath:@"tabBar"];
}

- (void)setupOneController:(UIViewController *)oneVc image:(NSString *)image  title:(NSString *)title
{
    if(image.length){
        NSString *selectName = [image stringByAppendingString:@"_p"];
        oneVc.tabBarItem.image = [UIImage imageNamed:image];
        oneVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    oneVc.tabBarItem.title = title;
    LJNavigationController *nav = [[LJNavigationController alloc] initWithRootViewController:oneVc];
    [self addChildViewController:nav];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    NSInteger index = [self.tabBar.items indexOfObject:item];
    [self animatedWithindex:index];
}

- (void)animatedWithindex:(NSInteger )index
{
    NSMutableArray *tabArr = [NSMutableArray array];
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabArr addObject:tabBarButton];
        }
    }
    CABasicAnimation *base = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    base.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    base.duration = 0.1;
    base.repeatCount = 1;
    base.autoreverses = YES;
    base.fromValue = [NSNumber numberWithFloat:0.8];
    base.toValue = [NSNumber numberWithFloat:1.2];
    [[tabArr[index] layer] addAnimation:base forKey:@"Base"];
}

- (void)cameraButtonClick:(LJTabBar *)tabBar
{
    LJCameraView *cameraView = [[LJCameraView alloc]initWithFrame:self.view.bounds];
    [cameraView setButtonClick:^(NSInteger tag) {
        switch (tag) {
            case LJCameraViewTypeLive://直播
            {
                LJLaunchViewController *launchVc = [[LJLaunchViewController alloc]init];
                [self presentViewController:launchVc animated:YES completion:nil];
            }
                break;
            case LJCameraViewTypeLittleVideo://短视频
            {
                UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
                UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                picker.allowsEditing = NO;
                picker.delegate = self;
                self.imagePickerController = picker;
                [self setupImagePicker:sourceType];
                picker = nil;
                self.modalPresentationStyle=UIModalPresentationOverCurrentContext;
                [self presentViewController:self.imagePickerController animated:YES completion:nil];
                
            }
                break;
            default:
                break;
        }
    }];
    [cameraView popShow];
}


- (void)setupImagePicker:(UIImagePickerControllerSourceType)sourceType{
    if (sourceType != UIImagePickerControllerSourceTypeCamera) {
        return;
    }
    self.imagePickerController.sourceType = sourceType;
    [[UIApplication sharedApplication]setStatusBarHidden:YES];
}


@end
