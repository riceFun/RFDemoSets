//
//  SelectorViewController.m
//  RFRuntimeDemo
//
//  Created by riceFun on 2018/12/14.
//  Copyright © 2018 riceFun. All rights reserved.
//

#import "SelectorViewController.h"
#import <objc/runtime.h>
#import "Person.h"
@interface SelectorViewController ()

@end

@implementation SelectorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    /*
     BOOL class_respondsToSelector(Class cls, SEL sel)
     - (BOOL)respondsToSelector:(SEL)aSelector; // 方法声明在 NSObject 协议中
     + (BOOL)instancesRespondToSelector:(SEL)aSelector; // 方法声明在 NSObject 类中
     
    三个函数 \ 方法的作用都是判断是否响应了某个方法，或者说是判断某个方法有没有被实现
     */
    
    Person *p = [[Person alloc]init];
    BOOL yn1 = class_respondsToSelector([Person class], @selector(ages)); // YES 指定的『实例方法』
    BOOL yn2 = class_respondsToSelector([Person class], @selector(run)); // NO 指定的『实例方法』
    BOOL yn3 = [[Person class] respondsToSelector:@selector(ages)]; // NO
    BOOL yn4 = [[Person class] respondsToSelector:@selector(run)]; // YES
    BOOL yn5 = [p respondsToSelector:@selector(ages)]; // YES
    BOOL yn6 = [p respondsToSelector:@selector(run)]; // NO
    BOOL yn7 = [[Person class] instancesRespondToSelector:@selector(ages)]; // YES
    BOOL yn8 = [[Person class] instancesRespondToSelector:@selector(run)];// NO
    int a = 0;
    /*
     1 . class_respondsToSelector 函数虽然参数需要传入一个类，但由yn1 和 yn2 的结果可知该函数是判断传入类中是否实现了指定的『实例方法』。
     2 . respondsToSelector 方法声明在 NSObject 协议中，调用者可以是实例也可以是类：由yn3 和 yn4 的结果可知，当调用者是类时，该方法是判断这个类中是否实现了指定的『类方法』；由yn5 和 yn6 的结果可知，当调用者是类的实例时，该方法是判断这个类中是否实现了指定的『实例方法』。
     3 . instancesRespondToSelector  方法声明在 NSObject 类中且是类方法，只能被类调用，由yn7 和 yn8 的结果可知，该方法是判断类中是否实现了指定的『实例方法』。
     
     
     //结论：class_respondsToSelector 函数和 instancesRespondToSelector 方法作用相同，和 respondsToSelector 方法被实例调用时的作用也相同。
     
     */
    
    
    
    
    
    
}



@end
