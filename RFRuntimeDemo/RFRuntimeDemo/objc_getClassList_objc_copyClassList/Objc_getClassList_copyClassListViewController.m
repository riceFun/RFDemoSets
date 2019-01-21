//
//  Objc_getClassList_copyClassListViewController.m
//  RFRuntimeDemo
//
//  Created by riceFun on 2018/12/14.
//  Copyright © 2018 riceFun. All rights reserved.
//

#import "Objc_getClassList_copyClassListViewController.h"
#import <objc/runtime.h>
@interface Objc_getClassList_copyClassListViewController ()

@end

@implementation Objc_getClassList_copyClassListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    /*1. int objc_getClassList(Class *buffer, int bufferCount)
     分析：该函数的作用是获取已经注册的类，他需要传入两个参数，
     参数：
     buffer：已经分配好内存空间的数组
     bufferCount：数组中可以存放元素的个数，当参数 bufferCount 值小于注册的类的总数时，获取到的是注册类的集合的任意子集
     返回值： 是注册类的总数
     ps：第一个参数传 NULL 时将会获取到当前注册的所有的类，此时可存放元素的个数为0，因此第二个参数可传0，返回值为当前注册的所有类的总数。
     */
    int numClasses = 0,newNumClasses = objc_getClassList(NULL, 0);//1 objc_getClassList 函数是为了获取到当前注册的所有类的总个数 newNumClasses
    Class *classes = NULL; // 2
    while (numClasses < newNumClasses) { // 3
        numClasses = newNumClasses; // 4
        classes = (Class *)realloc(classes, sizeof(Class) * numClasses); // 5根据 newNumClasses 调整数组 classes 的空间
        newNumClasses = objc_getClassList(classes, numClasses); // 6向已分配好内存空间的数组 classes 中存放元素
        
        //class_getName 函数获取每个类的名称
        for (int i = 0; i < numClasses; i++) { // 7
            const char *className = class_getName(classes[i]); // 8
            NSLog(@"%s", className); // 9
            
//            if (class_getSuperclass(classes[i]) == [UIScrollView class]) {
//                NSLog(@"subclass of UIScrollView : %s", className);
//            }
        } // 10
        
    } // 11
    free(classes); // 12
    
    //利用这个函数也可以获取到某一个类的所有子类，在上述代码的第9行和第10行之间添加如下代码即可：
//    if (class_getSuperclass(classes[i]) == [UIScrollView class]) {
//        NSLog(@"subclass of UIScrollView : %s", className);
//    }
    
    NSLog(@"================================================");
    /*2. Class *objc_copyClassList(unsigned int *outCount)
     该函数的作用是获取所有已注册的类，和上述函数 objc_getClassList 参数传入 NULL 和 0 时效果一样，
     */
    unsigned int outCount;
    Class *classes1 = objc_copyClassList(&outCount);
    for (int i = 0; i < outCount; i++) {
        NSLog(@"%s", class_getName(classes1[i]));
    }
    free(classes1);
    
    
    
    
    
    
    
    
    
    
    
    

}
@end
