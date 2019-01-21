//
//  UserInfoViewHelper.m
//  RFMVC_MVP_MVVM
//
//  Created by riceFun on 2019/1/3.
//  Copyright © 2019 riceFun. All rights reserved.
//

#import "UserInfoViewHelper.h"
@interface UserInfoViewHelper ()
@property (nonatomic,strong) UserInfoView_MVC *userInfoView;
@property (nonatomic,copy) NSString *userId;

@property (nonatomic,strong) UserInfo *userInfo;

@end

@implementation UserInfoViewHelper
+(instancetype)initHelperWithUserId:(NSString *)userId{
    return [[UserInfoViewHelper alloc]initWithUserId:userId];
}

-(instancetype)initWithUserId:(NSString *)userId{
    if (self = [super init]) {
        self.userId = userId;
        [self userInfoView];
        
        [self configLayout];
        
    }
    return self;
}

-(void)configLayout{
    
}

-(UIView *)helperView{
    return [self userInfoView];
}

-(void)UserInfoViewHelper_fecthDataWithCompletionHandler:(NetWorkCompletionHandler)completionHandler{
    [RFNetWorkManager fetchUserInfoWithUserId:@"1" completionHandler:^(NSError * _Nonnull error, id  _Nonnull result) {
        if (!error) {
            self.userInfo = result;
        }
        completionHandler ? completionHandler(error, result) : nil;
    }];
}

#pragma mark getter
-(UserInfoView_MVC *)userInfoView{
    if (!_userInfoView) {
        _userInfoView = [[UserInfoView_MVC alloc]init];
    }
    return _userInfoView;
}

#pragma mark setter
-(void)setUserInfo:(UserInfo *)userInfo{
    _userInfo = userInfo;
    
    self.userInfoView.iconImageView.image = [UIImage imageNamed:userInfo.userLogo];
    self.userInfoView.titleLabel.text = userInfo.userName;
    self.userInfoView.detailTitleLabel.text = [NSString stringWithFormat:@"%@  %@",userInfo.userProductionNum,userInfo.userFansNum];
    self.userInfoView.infoDescriptionLabel.text = userInfo.userInfoDescription;
}


@end
