//
//  PropertyViewController.m
//  RFRuntimeDemo
//
//  Created by riceFun on 2018/12/17.
//  Copyright © 2018 riceFun. All rights reserved.
//

#import "PropertyViewController.h"
#import <objc/runtime.h>
#import "Person.h"

@interface PropertyViewController ()
@property (nonatomic,assign) int num;

@end

@implementation PropertyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    /*1. objc_property_t class_getProperty(Class cls, const char *name)
     作用：通过属性名获取属性*/
    objc_property_t num = class_getProperty([PropertyViewController class], "num");
    num = 5;
    NSLog(@"num:%d",self.num);
    
    
    /*2. const char *property_getName(objc_property_t property)
     作用：获取属性的名称
     */
    objc_property_t property_t = class_getProperty([UIImageView class], "animationImages");
    const char *name = property_getName(property_t);//获取属性的名称
    NSLog(@"%s", name); // animationImages
    
    NSLog(@"==============================");
    /*3. objc_property_t *class_copyPropertyList(Class cls, unsigned int *outCount)
     作用：获取一个类的所有属性*/
    unsigned int propertyCount;
    objc_property_t *propertyList = class_copyPropertyList([Person class], &propertyCount);
    for (int i = 0; i < propertyCount; i++) {
        objc_property_t property_t = propertyList[i];
        NSLog(@"%s", property_getName(property_t));
    }
    free(propertyList);
    /*打印
     2018-12-17 17:13:31.799128+0800 RFRuntimeDemo[29111:1338751] childhoodName
     2018-12-17 17:13:31.799234+0800 RFRuntimeDemo[29111:1338751] color
     */
    NSLog(@"==============================");
    /*对比 class_copyPropertyList 和 class_copyIvarList*/
    unsigned int ivarCount;
    Ivar *ivarList = class_copyIvarList([Person class], &ivarCount);
    for (int i = 0; i < ivarCount; i++) {
        Ivar ivar = ivarList[i];
        const char * name = ivar_getName(ivar);
        NSLog(@"%s", name);
    }
    free(ivarList);
    /*打印
     2018-12-17 17:13:31.799444+0800 RFRuntimeDemo[29111:1338751] pet
     2018-12-17 17:13:31.799513+0800 RFRuntimeDemo[29111:1338751] _color
     2018-12-17 17:13:31.799625+0800 RFRuntimeDemo[29111:1338751] _childhoodName
     */
    /*结论
     1.用 class_copyPropertyList 获取到的属性名称，用 class_copyIvarList 也能获取到
     class_copyIvarList 获取到的还有pet 。
     2.class_copyIvarList 获取到的还有实例变量 和 成员变量，并且在所有属性名称前都有下划线 _
     */
  
}



@end
