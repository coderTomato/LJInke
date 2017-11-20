//
//  LiveViewController.m
//  LJInke
//
//  Created by Robin on 17/11/20.
//  Copyright © 2017年 Robin. All rights reserved.
//

#import "LiveViewController.h"
#import "LJLive.h"
#import "LJHotCell.h"
#import "LJHeader.h"
#import "LJPlayerViewController.h"


@interface LiveViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray * datalist;
/** 列表*/
@property (strong, nonatomic) UITableView *tableView;

@end

@implementation LiveViewController

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH - 49) style:UITableViewStylePlain];
        _tableView.delegate  = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = [UIScreen mainScreen].bounds.size.width * 1.3 + 1;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (NSMutableArray *)datalist {
    
    if (!_datalist) {
        _datalist = [NSMutableArray array];
    }
    return _datalist;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupHeader];
}

- (void)setupHeader
{
    LJHeader *header = [LJHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    [header beginRefreshing];
    self.tableView.mj_header = header;
}

- (void)loadData{
    [HttpTool getWithPath:INKeHotUrl params:nil success:^(id json) {
        NSArray *lives =  [LJLive mj_objectArrayWithKeyValuesArray:json[@"lives"]];
        [self.datalist addObjectsFromArray:lives];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
    }];
}

#pragma   UITableViewDataSource  UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datalist.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identifierId = @"InKeCellId";
    LJHotCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierId];
    if (cell == nil) {
        cell = [[LJHotCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierId];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.live = self.datalist[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LJLive * live = self.datalist[indexPath.row];
    LJPlayerViewController *playVc = [[LJPlayerViewController alloc] init];
    playVc.live = live;
    [self.navigationController pushViewController:playVc animated:YES];
}



@end
