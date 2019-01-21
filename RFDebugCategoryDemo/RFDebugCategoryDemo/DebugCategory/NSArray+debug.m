//
//  NSArray+debug.m
//  RFDebugCategoryDemo
//
//  Created by riceFun on 2018/12/6.
//  Copyright © 2018 riceFun. All rights reserved.
//

#import "NSArray+debug.h"
#import <objc/runtime.h>

@implementation NSArray (debug)
+(void)load{
    /** Method：  objectAtIndex
     NSArray objectAtIndex 其实是由其类簇类(子类工厂方法，每种子类负责某种父类的一种或者某种方法)  我们可已通过runtime的方法去查看当前当前操作该方法的子类到底是哪个方法 详见下面具体方法实现 DebugCategoryManager
     __NSArrayI 内部其实还有
     count
     objectAtIndex:
     getObjects:range:
     countByEnumeratingWithState:objects:count:
     enumerateObjectsWithOptions:usingBlock:
     objectAtIndexedSubscript:
     */
    Method fromMethod = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtIndex:));//为什么是__NSArrayI  而不是 NSArray 请看上面说明
    Method toMethod = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(debug_objectAtIndex:));
    method_exchangeImplementations(fromMethod, toMethod);
}

//debug method objectAtIndex
-(id)debug_objectAtIndex:(NSUInteger)index{
    if (self.count-1 < index) {
        // 这里做一下异常处理，不然都不知道出错了。
        @try {
            return [self debug_objectAtIndex:index];
        }
        @catch (NSException *exception) {
            // 在崩溃后会打印崩溃信息，方便我们调试。
            NSLog(@"---------- %s Crash Because Method %s  ----------\n", class_getName(self.class), __func__);
            NSLog(@"%@", [exception callStackSymbols]);
            return nil;
        }
        @finally {}
    } else {
        return [self debug_objectAtIndex:index];
    }
}

@end
