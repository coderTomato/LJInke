//

#import "NearbyViewController.h"
#import "LJNearLiveCell.h"
#import "LJLive.h"
#import "LJHeader.h"
#import "LJPlayerViewController.h"

static NSString *identifier = @"LJNearLiveCell";

#define kMargin 5
#define kItemWidth 100

@interface NearbyViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

/** 数据源*/
@property (strong, nonatomic) NSArray *datalist;

@end

@implementation NearbyViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupHeader];
}
- (void)setupHeader
{
  self.title = @"附近";
   [self.collectionView registerNib:[UINib nibWithNibName:@"LJNearLiveCell" bundle:nil] forCellWithReuseIdentifier:identifier];

   LJHeader *header = [LJHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
  header.lastUpdatedTimeLabel.hidden = YES;
   header.stateLabel.hidden = YES;
   [header beginRefreshing];
   self.collectionView.mj_header = header;
}

- (void)loadData
{
    [HttpTool getWithPath:NearFakeUrl params:nil success:^(id json) {
        if([json[@"dm_error"] integerValue])
        {
            
        }
        else
        {
            //如果返回信息正确
            self.datalist = [LJLive mj_objectArrayWithKeyValuesArray:json[@"lives"]];
            [self.collectionView reloadData];
            [self.collectionView.mj_header endRefreshing];
        }
    } failure:^(NSError *error) {
        [self.collectionView.mj_header endRefreshing];
    }];
}

//cell将要显示时调用
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
   LJNearLiveCell *liveCell = (LJNearLiveCell *)cell;
   [liveCell showAnimation];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger count = self.collectionView.ty_width / kItemWidth;
    CGFloat etraWidth = (self.collectionView.ty_width - kMargin * (count + 1)) / count;
    
    return CGSizeMake(etraWidth, etraWidth + 20);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.datalist.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LJNearLiveCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.live = self.datalist[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    LJLive * live = self.datalist[indexPath.row];
    LJPlayerViewController *playVc = [[LJPlayerViewController alloc] init];
    playVc.live = live;
    [self.navigationController pushViewController:playVc animated:YES];
}

@end
