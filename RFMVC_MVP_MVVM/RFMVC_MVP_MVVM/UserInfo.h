//
//  UserInfo.h
//  RFMVC_MVP_MVVM
//
//  Created by riceFun on 2019/1/2.
//  Copyright © 2019 riceFun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserInfo : NSObject
@property (nonatomic,copy) NSString *userLogo;
@property (nonatomic,copy) NSString *userName;
@property (nonatomic,copy) NSString *userProductionNum;
@property (nonatomic,copy) NSString *userFansNum;
@property (nonatomic,copy) NSString *userInfoDescription;

@end

NS_ASSUME_NONNULL_END
