//
//  IvarLayout_WeakIvarLayoutViewController.m
//  RFRuntimeDemo
//
//  Created by riceFun on 2018/12/17.
//  Copyright © 2018 riceFun. All rights reserved.
//


// https://www.jianshu.com/p/6b218d12caae

#import "IvarLayout_WeakIvarLayoutViewController.h"
#import <objc/runtime.h>
#import "Dog.h"
@interface IvarLayout_WeakIvarLayoutViewController ()

@end

@implementation IvarLayout_WeakIvarLayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    /*
     uint8_t
     #ifndef _UINT8_T
     #define _UINT8_T
     typedef unsigned char uint8_t;
     #endif _UINT8_T
     它本质上是unsigned char，一般是指无符号8位整型数。一个无符号8位整型数在16进制中是两位，恰好地，这两位中的后一位表示了连续的strong（或weak）类型的实例变量的数量，前一位表示连续的非strong（或weak）类型的实例变量的数量
     */
    
    
    printf("strong:\n");
    const uint8_t *array_s = class_getIvarLayout([Dog class]);
    int i = 0;
    uint8_t value_s = array_s[i];
    while (value_s != 0x0) {
        printf("\\x%02x\n", value_s);
        value_s = array_s[++i];
    }
    
    printf("----------\n");
    
    printf("weak:\n");
    const uint8_t *array_w = class_getWeakIvarLayout([Dog class]);
    int j = 0;
    uint8_t value_w = array_w[j];
    while (value_w != 0x0) {
        printf("\\x%02x\n", value_w);
        value_w = array_w[++j];
    }
    
    /*打印
     strong:class_getIvarLayout
     \x01 ：第一个\x01表示一开始有0个非strong类型的实例变量，这是因为第一个属性property_1_s是strong类型的，这也正是第二位16进制那个数字1所表示的；
     \x32 接下来有三个非strong类型的，两个strong类型的，即\x32;
     \x12 接下来有一个非strong类型的，两个strong类型的，即\x12;
     \x21 接下来有两个非strong类型的，一个strong类型的，即\x21;
     ----------
     weak:class_getWeakIvarLayout
     \x11
     \x11
     \x52
     
     ------- 举例 -------
     \x32  前一位3 前一位表示连续的非strong（或weak）类型的实例变量的数量为3
           后一位2 表示了连续的strong（或weak）类型的实例变量的数量为2
     */
    
}


@end
