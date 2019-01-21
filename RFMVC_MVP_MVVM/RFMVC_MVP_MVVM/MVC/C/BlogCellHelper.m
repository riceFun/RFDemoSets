//
//  BlogCellHelper.m
//  RFMVC_MVP_MVVM
//
//  Created by riceFun on 2019/1/4.
//  Copyright © 2019 riceFun. All rights reserved.
//

#import "BlogCellHelper.h"

@interface BlogCellHelper ()
@property (nonatomic,strong)Blog *blog;

@end

@implementation BlogCellHelper
+(instancetype)helperWithBlog:(Blog *)blog{
    return [[BlogCellHelper alloc]initWithBlog:blog];
}

-(instancetype)initWithBlog:(Blog *)blog{
    if (self = [super init]) {
        _blog = blog;
    }
    return self;
}

-(NSString *)title{
    return _blog.title;
}

-(NSString *)detailTitle{
    return _blog.detailTitle;
}

-(NSString *)likeText{
    return [NSString stringWithFormat:@"👍：%d",_blog.likeNum];
}

-(NSString *)dislikeText{
    return [NSString stringWithFormat:@"踩：%d",_blog.dislikeNum];
}

-(void)likeThisBlog{
    _blog.likeNum += 1;
    if (self.likeBlockblock) {
        self.likeBlockblock();
    }
}

@end

