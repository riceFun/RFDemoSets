//
//  Class_copyMethodListViewController.m
//  RFRuntimeDemo
//
//  Created by riceFun on 2018/12/17.
//  Copyright © 2018 riceFun. All rights reserved.
//

#import "Class_copyMethodListViewController.h"
#import <objc/runtime.h>
#import "Person.h"
@interface Class_copyMethodListViewController ()

@end

@implementation Class_copyMethodListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    /*1.Method *class_copyMethodList(Class cls, unsigned int *outCount)
     说明：该函数的作用是获取一个类的所有实例方法
     */
    
    unsigned int count;//1
    Method *methods = class_copyMethodList([Person class], &count);//2
    for (int i = 0; i < count; i ++) {//3
        NSLog(@"%s",sel_getName(method_getName(methods[i])));//4 method_getName 和 sel_getName 函数的作用是获取方法名称。
    }//5
    
    free(methods);//6
    /*打印结果：
     018-12-17 15:45:12.114655+0800 RFRuntimeDemo[28690:1320105] childhoodName
     2018-12-17 15:45:12.114780+0800 RFRuntimeDemo[28690:1320105] ages
     2018-12-17 15:45:12.114814+0800 RFRuntimeDemo[28690:1320105] setChildhoodName:
     2018-12-17 15:45:12.114846+0800 RFRuntimeDemo[28690:1320105] .cxx_destruct
     
     1 . 用 @property 修饰的属性会自动生成 set 和 get 两个方法，而成员变量不会；
     2 . 即使是私有属性自动生成的 set 、 get 方法和私有的实例方法也可以被 class_copyMethodList 函数获取到，而类方法不能被获取到；
     3 . 额外的 .cxx_destruct
     
     */
    
    
    /*获取类方法  传入元类*/
    unsigned int count1; // 1
    Class metaClass = object_getClass([Person class]); // 2获取元类的函数是 object_getClass
    Method *methods1 = class_copyMethodList(metaClass, &count1); // 3
    for (int i = 0; i < count1; i++) { // 4
        NSLog(@"%s", sel_getName(method_getName(methods1[i]))); // 5
    } // 6
    free(methods1); // 7
    
    /*打印结果：
     018-12-17 15:45:12.114655+0800 RFRuntimeDemo[28690:1320105] run
     
     */
    
    
}


@end
