//
//  LJTittleButton.m
//  LJInke
//
//  Created by Robin on 17/11/20.
//  Copyright © 2017年 Robin. All rights reserved.
//

#import "LJTittleButton.h"

@implementation LJTittleButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        self.titleLabel.font = LJTitleLabelFont;
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted {}

@end
