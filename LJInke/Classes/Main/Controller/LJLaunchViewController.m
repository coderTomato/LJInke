//
//  LJLaunchViewController.m
//  LJInke
//
//  Created by Robin on 17/11/20.
//  Copyright © 2017年 Robin. All rights reserved.
//

#import "LJLaunchViewController.h"
#import "LFLivePreview.h"

@interface LJLaunchViewController ()
@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UIView *middleView;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;

@end

@implementation LJLaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    //设置键盘TextField
    [self setupTextField];
}

#pragma mark ---- <设置键盘TextField>
- (void)setupTextField
{
    [_titleField becomeFirstResponder];
    
    //设置键盘颜色
    _titleField.tintColor = [UIColor whiteColor];
    
    //设置占位文字颜色
    [_titleField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
}

- (void)viewDidDisappear:(BOOL)animated
{
    //隐藏状态栏
    [[UIApplication sharedApplication] setStatusBarHidden:TRUE];
}

//返回主界面
- (IBAction)backBtnClicked:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    // 显示状态栏
    [[UIApplication sharedApplication] setStatusBarHidden:false];
}
//开始直播采集
- (IBAction)begin:(id)sender
{
    [_titleField resignFirstResponder];
    LFLivePreview * preView = [[LFLivePreview alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:preView];
    //开启直播
    [preView startLive];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_titleField resignFirstResponder];
}

@end
