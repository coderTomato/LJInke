
#import <UIKit/UIKit.h>

@class LJTabBar;

@protocol LJTabBarDelegate <UITabBarDelegate>

@optional
- (void)cameraButtonClick:(LJTabBar *)tabBar;

@end

@interface LJTabBar : UITabBar

@property (weak, nonatomic) id <LJTabBarDelegate> delegate;

@end
