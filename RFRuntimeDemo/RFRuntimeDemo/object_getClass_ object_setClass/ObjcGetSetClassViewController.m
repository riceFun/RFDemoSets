//
//  ObjcGetSetClassViewController.m
//  RFRuntimeDemo
//
//  Created by riceFun on 2018/12/13.
//  Copyright © 2018 riceFun. All rights reserved.
//

#import "ObjcGetSetClassViewController.h"
#import "Animal.h"
#import <objc/runtime.h>
@interface ObjcGetSetClassViewController ()

@end

@implementation ObjcGetSetClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    /*1. object_getClass(const char * _Nonnull name)  获取对象的类*/
    Animal *obj = [[Animal alloc]init];//1
    Class objClass = objc_getClass("Animal_Dog");//2_1 objc_getClass参数是类名的字符串，返回的就是这个类的类对象；
    Class objClass_look = objc_lookUpClass("Animal_Dog");
    Class objClass1 = object_getClass(obj); // 2_2 object_getClass参数是id类型，它返回的是这个id的isa指针所指向的Class，如果传参是Class，则返回该Class的metaClass。
    NSLog(@"\nobjc_getClass:%@\nobjClass_look:%@#\nobject_getClass:%@",NSStringFromClass(objClass),NSStringFromClass(objClass_look),NSStringFromClass(objClass1)); // 3
    
    Class nsobjectClass = object_getClass([Animal class]); // 4
    NSLog(@"%@", NSStringFromClass(nsobjectClass)); // 5
    
    //class_isMetaClass函数的作用是判断传入的类是不是元类
    BOOL isMeta1 = class_isMetaClass(objClass); // 6
    BOOL isMeta2 = class_isMetaClass(nsobjectClass); // 7
    NSLog(@"isMeta1:%i, isMeta2:%i", isMeta1, isMeta2); // 8
    //打印：isMeta1:0, isMeta2:1  ==》结论：object_getClass函数的参数传一个类的实例时，返回的是该实例的类；参数传类时，返回的是该类的元类
    
    Class class1 = [obj class];
    Class class2 = [Animal class] ;
    NSLog(@"class1：%@", NSStringFromClass(class1));
    NSLog(@"class2：%@", NSStringFromClass(class2));
    NSLog(@"isMeta1：%i, isMeta2：%i", class_isMetaClass(class1), class_isMetaClass(class2));
    //打印：isMeta1:0, isMeta2:0 ==> 结论：class方法的调用者是一个实例时，获取到的是该实例的类，此时和object_getClass函数作用相同；而调用者是一个类（比如[NSObject class]）时，获取到的并不是该类的元类，此时和object_getClass函数的作用不同
    
    
    /*object_setClass(id  _Nullable obj, Class  _Nonnull __unsafe_unretained cls)  为一个对象设置一个指定的类。*/
    // 分别创建一个可变数组对象mutArray和不可变数组对象array
    NSMutableArray *mutArray = [NSMutableArray arrayWithObjects:@"a", @"b", nil]; // 1
    NSArray *array = @[@"c", @"d"]; // 2
    
    // 获取这两个对象mutArray和array的类并打印
    Class mutArrayClassBefore = object_getClass(mutArray); // 3
    Class arrayClassBefore = object_getClass(array); // 4
    NSLog(@"%@ -- %@", NSStringFromClass(mutArrayClassBefore), NSStringFromClass(arrayClassBefore)); // 5
    
    Class setclass = object_setClass(mutArray, arrayClassBefore); // 6  isa change to  arrayClassBefore class
    NSLog(@"%@", NSStringFromClass(setclass)); // 7
    
    Class mutArrayClassNow = object_getClass(mutArray); // 8
    Class arrayClassNow = object_getClass(array); // 9
    
    NSLog(@"%@ -- %@", NSStringFromClass(mutArrayClassNow), NSStringFromClass(arrayClassNow)); // 10
    /*
     runtime[41222:4366321] __NSArrayM -- __NSArrayI  （第5行打印）
     runtime[41222:4366321] __NSArrayM                （第7行打印）
     runtime[41222:4366321] __NSArrayI -- __NSArrayI  （第10行打印）
     */
//    此时再用mutArray调用NSMutableArray的方法会导致程序crash，如
//    [mutArray addObject:@"e"]; // 11 crash:-[__NSArrayI addObject:]: unrecognized selector sent to instance 0x282cd3450
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
