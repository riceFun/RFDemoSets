//
//  UserInfoView_Normal_Modify.m
//  RFMVC_MVP_MVVM
//
//  Created by riceFun on 2019/1/2.
//  Copyright © 2019 riceFun. All rights reserved.
//

#import "UserInfoView_Normal_Modify.h"

@interface UserInfoView_Normal_Modify ()
@property (nonatomic,strong) UIImageView *iconImageView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *detailTitleLabel;
@property (nonatomic,strong) UILabel *infoDescriptionLabel;

@end

@implementation UserInfoView_Normal_Modify

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.iconImageView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.detailTitleLabel];
        [self addSubview:self.infoDescriptionLabel];
        
        [self addSubview:self.segmentControl];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.iconImageView.mas_bottom).offset(0);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];
    
    [self.detailTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(0);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];
    
    [self.infoDescriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.detailTitleLabel.mas_bottom).offset(5);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(40);
        
        //        make.bottom.mas_lessThanOrEqualTo(self.mas_bottom).offset(-10).priority(900);
    }];
    
    [self.segmentControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.infoDescriptionLabel.mas_bottom).offset(5);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];
    
}

#pragma mark getter
-(UIImageView *)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc]init];
    }
    return _iconImageView;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

-(UILabel *)detailTitleLabel{
    if (!_detailTitleLabel) {
        _detailTitleLabel = [[UILabel alloc]init];
        _detailTitleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _detailTitleLabel;
}

-(UILabel *)infoDescriptionLabel{
    if (!_infoDescriptionLabel) {
        _infoDescriptionLabel = [[UILabel alloc]init];
    }
    return _infoDescriptionLabel;
}

-(UISegmentedControl *)segmentControl{
    if (!_segmentControl) {
        _segmentControl = [[UISegmentedControl alloc]initWithItems:@[@"已发布",@"草稿箱"]];
        _segmentControl.tintColor = [UIColor blackColor];
        _segmentControl.selectedSegmentIndex = 0;
    }
    return _segmentControl;
}

#pragma mark setter
- (void)setUserInfo:(UserInfo *)userInfo{
    _userInfo = userInfo;
    
    self.iconImageView.image = [UIImage imageNamed:userInfo.userLogo];
    self.titleLabel.text = userInfo.userName;
    self.detailTitleLabel.text = [NSString stringWithFormat:@"%@  %@",userInfo.userProductionNum,userInfo.userFansNum];
    self.infoDescriptionLabel.text = userInfo.userInfoDescription;
    
    //    [self layoutIfNeeded];
}

@end

