//
//  BlogTableViewHelper.h
//  RFMVC_MVP_MVVM
//
//  Created by riceFun on 2019/1/3.
//  Copyright © 2019 riceFun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoViewHelper.h"

NS_ASSUME_NONNULL_BEGIN

@interface BlogTableViewHelper : NSObject

+(instancetype)initHelperWithUserId:(NSString *)userId;
-(UIView *)helperView;
-(void)BlogTableViewHelper_fecthDataWithCompletionHandler:(NetWorkCompletionHandler)completionHandler;

@end

NS_ASSUME_NONNULL_END
