//
//  UserInfoViewHelper.h
//  RFMVC_MVP_MVVM
//
//  Created by riceFun on 2019/1/3.
//  Copyright © 2019 riceFun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoView_MVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserInfoViewHelper : NSObject
+(instancetype)initHelperWithUserId:(NSString *)userId;
-(UIView *)helperView;

-(void)UserInfoViewHelper_fecthDataWithCompletionHandler:(NetWorkCompletionHandler)completionHandler;

@end

NS_ASSUME_NONNULL_END
