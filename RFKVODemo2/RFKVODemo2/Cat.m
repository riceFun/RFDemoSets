//
//  Cat.m
//  RFKVODemo2
//
//  Created by riceFun on 2018/12/13.
//  Copyright © 2018 riceFun. All rights reserved.
//

#import "Cat.h"
#import "Dog.h"
#import <objc/message.h>

@implementation Cat
-(void)eat{
    NSLog(@"%@ eat",NSStringFromClass([self class]));
    
//    struct objc_super superClazz = {
//        .receiver = self,
//        .super_class = class_getSuperclass(object_getClass(self))
//    };
//
//    // 调用原方法
//    void (*objc_msgSendSuperCasted)(void *, SEL) = (void *)objc_msgSendSuper;
//
//    objc_msgSendSuperCasted(&superClazz, _cmd);
    

}

-(void)drink{
    NSLog(@"cat drink");
}

@end
