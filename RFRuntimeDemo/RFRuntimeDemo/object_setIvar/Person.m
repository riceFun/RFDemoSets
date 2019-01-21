//
//  Person.m
//  RFRuntimeDemo
//
//  Created by riceFun on 2018/12/14.
//  Copyright © 2018 riceFun. All rights reserved.
//

#import "Person.h"
@interface Person()
{
    NSString *pet;//成员变量
}

/** 小名 */
@property (nonatomic, weak) NSString *childhoodName;//属性

@end

@implementation Person
+ (void)run
{
    NSLog(@"run");
}
- (int)ages
{
    return 30;
}
@end
