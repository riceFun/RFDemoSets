//
//  DebugCategoryManager.m
//  RFDebugCategoryDemo
//
//  Created by riceFun on 2018/12/6.
//  Copyright © 2018 riceFun. All rights reserved.
//

#import "DebugCategoryManager.h"
#import <objc/runtime.h>

@implementation DebugCategoryManager

+(id)get_NSArray_objectAtIndex_tureClass{
    //在这里进行自己需要的操作 eg：
    
    NSArray *array = [[NSArray alloc]init];
    array = @[@"f",@"e",@"r"];
    NSString *result = [array objectAtIndex:1];
    id tureClass = object_getClass(array); //真实类
    NSLog(@"%@",tureClass);
    return tureClass;
}

+(void)get_object_methodListWith:(NSString *)className{
    unsigned int count;
    //获取方法列表，所有在.m文件显式实现的方法都会被找到，包括setter+getter方法：
    Method *allMethods = class_copyMethodList(NSClassFromString(className), &count);
    for (int i = 0 ; i < count ; i++) {
        //Method:runtime声明的一个宏，表示一个方法
        Method md = allMethods[i];
        //获取SEL：SEL类型，即获取方法选择器@selector()
        SEL sel = method_getName(md);
        const char *methodName = sel_getName(sel);
        NSLog(@"MethodName:%s",methodName);
    }
}

@end
