//
//  BlogCellHelper.h
//  RFMVC_MVP_MVVM
//
//  Created by riceFun on 2019/1/4.
//  Copyright © 2019 riceFun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^BlogCellHelper_LikeBlock) (void);

@interface BlogCellHelper : NSObject
+(instancetype)helperWithBlog:(Blog *)blog;
@property (nonatomic,copy) BlogCellHelper_LikeBlock likeBlockblock;

-(NSString *)title;

-(NSString *)detailTitle;

-(NSString *)likeText;

-(NSString *)dislikeText;

-(void)likeThisBlog;


@end

NS_ASSUME_NONNULL_END
