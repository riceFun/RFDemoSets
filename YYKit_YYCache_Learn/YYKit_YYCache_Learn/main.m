//
//  main.m
//  YYKit_YYCache_Learn
//
//  Created by riceFun on 2019/1/24.
//  Copyright © 2019 riceFun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"


@interface ABSClass : NSObject
@property (nonatomic, copy) NSString *name;
@end
@implementation ABSClass
@end

int main(int argc, char * argv[]) {
//    @autoreleasepool {
//        
//        void *p;
//        {//增加作用域
//            ABSClass *objc = [[ABSClass alloc]init];
//            objc.name = @"我们";
//            p = (__bridge_retained void*)objc;// oc ->  c  __bridge_retained 就相当于 MRC 下的 retain ，将内存计数器 +1，然后用 void *p 指向改内存，所以当 *objc过了作用域，引用计算器 -1，也并没有释放 void *p 所引用的内存。
//        }
//        NSLog(@"%@", [(__bridge ABSClass *)p name]); //c -> oc
//        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
//    }
    
    @autoreleasepool {
        void *p;
        @autoreleasepool {
            ABSClass *obj = [[ABSClass alloc] init];
            obj.name = @"我们";
            p = (__bridge_retained void *)obj;
        }
        id obj = (__bridge_transfer id)p;
        NSLog(@"%@", [(__bridge ABSClass *)p name]);
        NSLog(@"%@", [(ABSClass *)obj name]);
        NSLog(@"Hello, World!");
    }
    return 0;
}
