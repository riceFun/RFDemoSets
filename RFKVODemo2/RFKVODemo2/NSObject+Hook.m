//
//  NSObject+Hook.m
//  RFKVODemo2
//
//  Created by riceFun on 2018/12/13.
//  Copyright © 2018 riceFun. All rights reserved.
//

#import "NSObject+Hook.h"
#import <objc/runtime.h>

@implementation NSObject (Hook)
+ (void)hookWithInstance:(id)instance method:(SEL)selector newclass:(Class)targetClass{
    
    Method originInstanceMethod = class_getInstanceMethod([instance class], selector);
    Method originClassMethod = class_getClassMethod([instance class], selector);
    if (originInstanceMethod) {
        // 修改 isa 指针的指向
        object_setClass(instance, targetClass);
    }else if (originClassMethod) {
        // 修改 isa 指针的指向  就是给某个对象 指定类
//        object_setClass(instance, targetClass);//object_setClass(id _Nullable obj, Class _Nonnull cls)  instance 只可以为实例 所以或崩溃
        return;
    }else{
        NSLog(@"NO Method!");
        return;
    }
    
    
}

@end
