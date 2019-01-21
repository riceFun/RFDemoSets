//
//  RFNetWorkManager.h
//  RFMVC_MVP_MVVM
//
//  Created by riceFun on 2019/1/2.
//  Copyright © 2019 riceFun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^NetWorkCompletionHandler)(NSError *error, id result);

@interface RFNetWorkManager : NSObject
+(void)fetchUserInfoWithUserId:(NSString *)userId completionHandler:(NetWorkCompletionHandler)completionHandler;

+(void)fetchUserBlogsWithUserId:(NSString *)userId completionHandler:(NetWorkCompletionHandler)completionHandler;

+(void)fetchUserDraftsWithUserId:(NSString *)userId completionHandler:(NetWorkCompletionHandler)completionHandler;

@end

NS_ASSUME_NONNULL_END
