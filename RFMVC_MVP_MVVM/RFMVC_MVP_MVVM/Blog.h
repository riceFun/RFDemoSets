//
//  Blog.h
//  RFMVC_MVP_MVVM
//
//  Created by riceFun on 2019/1/2.
//  Copyright © 2019 riceFun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Blog : NSObject
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *detailTitle;
@property (nonatomic,assign) int likeNum;
@property (nonatomic,assign) int dislikeNum;

@end

NS_ASSUME_NONNULL_END
