//
//  UserInfoView_Normal_Modify.h
//  RFMVC_MVP_MVVM
//
//  Created by riceFun on 2019/1/2.
//  Copyright © 2019 riceFun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserInfoView_Normal_Modify : UIView
@property (nonatomic,strong) UserInfo *userInfo;
@property (nonatomic,strong) UISegmentedControl *segmentControl;

@end

NS_ASSUME_NONNULL_END
