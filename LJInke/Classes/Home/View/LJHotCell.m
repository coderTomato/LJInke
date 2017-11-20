//
//  LJHotCell.m
//  LJInke
//
//  Created by Robin on 17/11/20.
//  Copyright © 2017年 Robin. All rights reserved.
//

#import "LJHotCell.h"


@implementation LJHotCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    _iconImageView = [[UIImageView alloc]init];
    _iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_iconImageView];
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(10);
        make.left.equalTo(self.contentView).with.offset(5);
        make.height.width.equalTo(@45);
    }];
    _iconImageView.layer.cornerRadius = 45/2;
    _iconImageView.layer.masksToBounds = YES;
    
    
    _nameLabel = [[UILabel alloc]init];
    _nameLabel.numberOfLines = 1;
    _nameLabel.textColor = [UIColor grayColor];
    _nameLabel.font = [UIFont fontWithName:@"Candara" size:15];
    [self.contentView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_iconImageView.mas_top);
        make.left.equalTo(_iconImageView.mas_right).offset(10);
        make.height.equalTo(@20);
        make.width.equalTo(@200);
    }];
    
    
    _cityLabel = [[UILabel alloc]init];
    _cityLabel.textColor = [UIColor grayColor];
    _cityLabel.font = [UIFont fontWithName:@"Candara" size:13];
    [self.contentView addSubview:_cityLabel];
    [_cityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLabel.mas_bottom).offset(3);
        make.left.equalTo(_nameLabel.mas_left);
        make.height.equalTo(_nameLabel.mas_height);
        make.width.equalTo(@100);
    }];
    
    _onLineLabel = [[UILabel alloc]init];
    _onLineLabel.textAlignment = NSTextAlignmentRight;
    _onLineLabel.font = [UIFont systemFontOfSize:15];
    _onLineLabel.textColor = [UIColor orangeColor];
    [self.contentView addSubview:_onLineLabel];
    [_onLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLabel.mas_top);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.width.equalTo(@70);
        make.height.equalTo(@45);
    }];
    
    _coverImageView = [[UIImageView alloc]init];
    _coverImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:_coverImageView];
    [_coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_iconImageView.mas_bottom).offset(10);
        make.left.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
    }];
    
    _logoImageView = [[UIImageView alloc]init];
    _logoImageView.image = [UIImage imageNamed:@"live_tag_live"];
    _logoImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_logoImageView];
    [_logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_coverImageView.mas_right).offset(-10);
        make.top.equalTo(_coverImageView.mas_top).offset(10);
        make.width.mas_equalTo(_logoImageView.mas_height).multipliedBy(1.3);
    }];
}

- (void)setLive:(LJLive *)live
{
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:live.creator.portrait] placeholderImage:[UIImage imageNamed:@"default_head"]];
    _nameLabel.text = [NSString stringWithFormat:@"%@",live.creator.nick];
    _cityLabel.text = [NSString stringWithFormat:@"%@ >",live.city];
    if (live.city.length == 0) {
        _cityLabel.text = [NSString stringWithFormat:@"难道在火星？ >"];
    }
    _onLineLabel.text = [NSString stringWithFormat:@"%ld",(long)live.onlineUsers];
    [_coverImageView sd_setImageWithURL:[NSURL URLWithString:live.creator.portrait] placeholderImage:[UIImage imageNamed:@"rectangleDefaultAvatar"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
