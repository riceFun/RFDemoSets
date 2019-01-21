//
//  RFNetWorkManager.m
//  RFMVC_MVP_MVVM
//
//  Created by riceFun on 2019/1/2.
//  Copyright © 2019 riceFun. All rights reserved.
//

#import "RFNetWorkManager.h"

@implementation RFNetWorkManager

+(void)fetchUserInfoWithUserId:(NSString *)userId completionHandler:(NetWorkCompletionHandler)completionHandler{

    NSUInteger delayTime = 1.5;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UserInfo *info = [[UserInfo  alloc]init];
        info.userLogo = @"logo";
        info.userName = @"城西吴彦祖";
        info.userProductionNum = @"作品：30";
        info.userFansNum = @"粉丝：8";
        info.userInfoDescription = @"个人简介：xxxx";
        !completionHandler ?: completionHandler(nil, info);
    });
    
}


+(void)fetchUserBlogsWithUserId:(NSString *)userId completionHandler:(NetWorkCompletionHandler)completionHandler{
    Blog *blog = [Blog new];
    blog.title = @"iOS 入门";
    blog.detailTitle = @"介绍如何画UIButton";
    blog.likeNum = 9;
    blog.dislikeNum = 99;
    
    Blog *blog1 = [Blog new];
    blog1.title = @"Runtime";
    blog1.detailTitle = @"runtime 是什么";
    blog1.likeNum = 9;
    blog1.dislikeNum = 99;
    
    Blog *blog2 = [Blog new];
    blog2.title = @"颈椎护理";
    blog2.detailTitle = @"三行代码 治好你的颈椎";
    blog2.likeNum = 8888;
    blog2.dislikeNum = 8;
    
    Blog *blog3 = [Blog new];
    blog3.title = @"如何黑隔壁小姐姐的电脑";
    blog3.detailTitle = @"黑她电脑是为了帮她修电脑";
    blog3.likeNum = 999999;
    blog3.dislikeNum = 0;
    
    NSUInteger delayTime = 1.5;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        !completionHandler ?: completionHandler(nil, [@[blog,blog1,blog2,blog3] copy]);
        
    });
    
    
}

+(void)fetchUserDraftsWithUserId:(NSString *)userId completionHandler:(NetWorkCompletionHandler)completionHandler{
    Draft *draft = [Draft new];
    draft.title = @"需求";
    draft.detailTitle = @"根据手机壳颜色，给app定制主题";
    draft.dateString = @"1992.11.22";
    
    Draft *draft1 = [Draft new];
    draft1.title = @"设计";
    draft1.detailTitle = @"如何撬动地球";
    draft1.dateString = @"1997.11.22";
    
    Draft *draft2 = [Draft new];
    draft2.title = @"如何科学的翻墙";
    draft2.detailTitle = @"翻墙前 请三思";
    draft2.dateString = @"2008.11.22";
    
    Draft *draft3 = [Draft new];
    draft3.title = @"党员报告";
    draft3.detailTitle = @"一心向党 ...";
    draft3.dateString = @"3005.11.22";
    
    NSUInteger delayTime = 1.5;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        !completionHandler ?: completionHandler(nil, [@[draft,draft1,draft2,draft3] copy]);
        
    });
    
}

@end
