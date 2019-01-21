//
//  Dog.m
//  RFKVODemo2
//
//  Created by riceFun on 2018/12/13.
//  Copyright © 2018 riceFun. All rights reserved.
//

#import "Dog.h"

@implementation Dog
-(void)eat{
    NSLog(@"%@ eat",NSStringFromClass([self class]));
}

+(void)drink{
    NSLog(@"%@ drink",NSStringFromClass([self class]));
}
@end
