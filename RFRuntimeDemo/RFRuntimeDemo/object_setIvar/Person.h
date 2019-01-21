//
//  Person.h
//  RFRuntimeDemo
//
//  Created by riceFun on 2018/12/14.
//  Copyright © 2018 riceFun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject
@property (nonatomic,strong) NSString *color;
+ (void)run;
- (int)ages;
@end

NS_ASSUME_NONNULL_END
