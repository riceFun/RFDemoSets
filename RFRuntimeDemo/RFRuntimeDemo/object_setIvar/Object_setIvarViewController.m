//
//  Object_setIvarViewController.m
//  RFRuntimeDemo
//
//  Created by riceFun on 2018/12/14.
//  Copyright © 2018 riceFun. All rights reserved.
//

#import "Object_setIvarViewController.h"
#import <objc/runtime.h>

#import "Person.h"

@interface Object_setIvarViewController ()

@end

@implementation Object_setIvarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    /*void object_setIvar(id obj, Ivar ivar, id value)
     说明：该函数的作用是将实例obj的实例变量ivar赋值为value
     */
    unsigned int count;//1
    Ivar *ivars = class_copyIvarList([Person class], &count);//2
    for (int i = 0; i < count; i ++) {//3
        Ivar ivar = ivars[i];//4
        NSLog(@"%s",ivar_getName(ivar));//5
    }//6
    //打印结果如下：_childhoodName
    
    Ivar ivar = class_getInstanceVariable([Person class], "_childhoodName");//7
    
    //仅仅通过 alloc init 初始化的 Person 实例 p 并没有给 _childhoodName 实例变量赋值『说明』，因此下列代码执行后打印结果为空
    Person *p = [[Person alloc]init];//8
    id name = object_getIvar(p, ivar);
    NSLog(@"%@",name);
    //打印结果如下：(null)
    
    //现在 Ivar 参数有了，尝试使用 object_setIvar 函数对 Ivar 赋值，并打印赋值后的 Ivar 的值：
    object_setIvar(p, ivar, @"榴莲");
    id newName = object_getIvar(p, ivar);
    NSLog(@"%@",newName);
    //打印结果如下：榴莲

    
    
    
}
@end
