//
//  UserInfoView_MVC.h
//  RFMVC_MVP_MVVM
//
//  Created by riceFun on 2019/1/4.
//  Copyright © 2019 riceFun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserInfoView_MVC : UIView
@property (nonatomic,strong) UIImageView *iconImageView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *detailTitleLabel;
@property (nonatomic,strong) UILabel *infoDescriptionLabel;
@property (nonatomic,strong) UISegmentedControl *segmentControl;

@end

NS_ASSUME_NONNULL_END
