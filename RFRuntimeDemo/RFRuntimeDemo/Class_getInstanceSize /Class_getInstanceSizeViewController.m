//
//  Class_getInstanceSizeViewController.m
//  RFRuntimeDemo
//
//  Created by riceFun on 2018/12/14.
//  Copyright © 2018 riceFun. All rights reserved.
//

#import "Class_getInstanceSizeViewController.h"
#import <objc/runtime.h>
#import "Son.h"
#import "LittlePerson.h"
@interface Class_getInstanceSizeViewController ()

@end

@implementation Class_getInstanceSizeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    /*size_t class_getInstanceSize(Class cls)
     说明：该函数的作用是获取类的实例所占用内存的大小（单位是字节）
     */
    //1. 以 NSObject 类为例，代码示例如下：
    size_t size = class_getInstanceSize([NSObject class]);
    NSLog(@"%zu", size);
    //在模拟器iPhone 4s和iPhone 5上运行打印结果是4，在iPhone 5s及之后的机型运行打印结果是8。
    //分析：Objective-C中，每个对象内部都有一个 isa 指针，指向该对象的类；一个类从另一角度来说也是一个对象，类也有一个 isa 指针，指向该类的元类。因此上述代码打印出的结果，就是 NSObject 实例中 isa 指针所占用的字节数。
    /*
     32位系统下：
     char a; // 1
     short b; // 2
     int c; // 4
     long d; // 4
     float e; // 4
     long long f; // 8
     double g; // 8
     int *h; // 4
     
     64位系统下：
     char a; // 1
     short b; // 2
     int c; // 4
     long d; // 8
     float e; // 4
     long long f; // 8
     double g; // 8
     int *h; // 8
     
     可见32位和64位系统中只有 long 和 指针 类型所占用的字节数不同。
    */
     //自定义类- Person 类
    size_t SonSize = class_getInstanceSize([Son class]);
    NSLog(@"%zu", SonSize);
    /*
     打印结果为32，这是内部的 isa 指针和两个 NSString 指针、一个 int 类型一共占用的字节数。刚才测试的 int 类型在64位系统下所占字节数为4，为什么现在和3个指针所占用的字节数加起来是32呢？这是因为『字节对齐』。
     */
    
    //自定义类- LittlePerson 类
    size_t LittlePersonSize = class_getInstanceSize([LittlePerson class]);
    NSLog(@"%zu", LittlePersonSize);
    
    
    //要注意的是 class_getInstanceSize 函数和 sizeof() 并不等同
    size_t InstanceSize = class_getInstanceSize([Class_getInstanceSizeViewController class]);
    NSLog(@"InstanceSize: %zu", InstanceSize);
    
    Class_getInstanceSizeViewController *vc = [[Class_getInstanceSizeViewController alloc] init];
    NSLog(@"sizeof: %ld", sizeof(vc));
    NSLog(@"sizeof: %ld", sizeof([Class_getInstanceSizeViewController class]));
    /*打印
     runtime[57907:5849922] InstanceSize: 696
     runtime[57907:5849922] sizeof: 8
     runtime[58021:5856762] sizeof: 8
     */
    
    
    
    
    
    
    
    
    
}

@end
