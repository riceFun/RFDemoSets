//
//  SimpleFunctionSetsViewController.m
//  RFRuntimeDemo
//
//  Created by riceFun on 2018/12/14.
//  Copyright © 2018 riceFun. All rights reserved.
//

#import "SimpleFunctionSetsViewController.h"
#import <objc/runtime.h>
#import "Pig.h"

@interface SimpleFunctionSetsViewController ()

@end

@implementation SimpleFunctionSetsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    /*1. BOOL object_isClass(id obj) 判断传入的参数是不是一个类（或元类）*/
    //获取字符串的类
    Class stringClass = [@"riceFun" class];
    BOOL isClass1 = object_isClass(stringClass);
    NSLog(@"stringClass is class:%i",isClass1);
    
    //获取NSObject 的元类
    Class nsobjectClass = object_getClass([NSObject class]);
    BOOL isClass2 = object_isClass(nsobjectClass);
    NSLog(@"nsobjectClass is class:%i",isClass2);
    
    
    /*2. const char *object_getClassName(id obj) 获取传入参数的类的名称，返回的是C语言字符串类型*/
    NSObject *obj = [[NSObject alloc]init];
    const char *className = object_getClassName(obj);
    NSLog(@"obj className is :%s",className);
    
    Pig *pig = [[Pig alloc]init];
    const char *pigClassName = object_getClassName(pig);
    NSLog(@"pig class is :%s",pigClassName);
    
    //说明：平常用的方法
    NSLog(@"%@",[pig class]);
    NSLog(@"%@",NSStringFromClass([pig class]));
    
    
    /*3. Class objc_getClass(const char *name) 通过传入的字符串获取类，如果不存在名为该字符串的类则返回nil*/
    Class class1 = object_getClass(@"Pig");
    Class class2 = object_getClass(@"Duck");//这个类其实并不存在
    NSLog(@"class1:%@\nclass2:%@", NSStringFromClass(class1),NSStringFromClass(class2));
   //打印：class1:Pig  class2:（null）
    
    //常用方法：
    Class class3 = NSClassFromString(@"Pig");
    
    
    /*4. Class objc_getMetaClass(const char *name) 和 BOOL class_isMetaClass(Class cls)
     objc_getMetaClass ：通过传入的字符串获取元类，如果不存在名为该字符串的元类则返回nil
     class_isMetaClass ：判断传入的类是不是元类
     */
    
    Class metaClass = objc_getMetaClass("Pig");
    NSLog(@"Pig's metaClass is %@", NSStringFromClass(metaClass));
    NSLog(@"%d", class_isMetaClass(metaClass));
    
    
    /*5. Class objc_lookUpClass(const char *name) 通过传入的字符串获取类，如果不存在名为该字符串的类则返回nil*/
    //说明：此函数与序号3 objc_getClass 函数使用方法完全相同，作用也基本相同，不同的地方在于：当一个类还没有被注册时， objc_getClass 函数会调用类的回调然后再次检查这个类是否被注册，而 objc_lookUpClass 函数不会调用回调。
    
    
    /*6. Class objc_getRequiredClass(const char *name) 通过传入的字符串获取类。*/
    //说明：此函数与序号3 objc_getClass 函数使用方法完全相同，作用也基本相同，不同的地方在于：如果不存在名为该字符串的类则杀掉进程从而crash。
//    Class class = objc_getRequiredClass("Duck");//code will crash,because  No Duck Class
    
    
    /*7. const char *class_getName(Class cls) 获取传入的类的名称，返回的是C语言字符串类型
     */
    const char *name = class_getName([UITableView class]);
    NSLog(@"UITableView's class name is : %s",name);
    //说明：我们平时常用的是以下两种方法
    NSLog(@"%@", [UITableView class]);
    NSLog(@"%@", NSStringFromClass([UITableView class]));
    
    
    /*8. Class class_getSuperclass(Class cls) 获取传入的类的父类*/
    Class superClass = class_getSuperclass([UITableView class]);
    NSLog(@"UITableView's superClass name is : %@",NSStringFromClass([superClass class]));
    //说明：我们平时常用的是以下方法获取父类 [UITableView superclass]
     NSLog(@"UITableView's superClass name is : %@",NSStringFromClass([UITableView superclass]));
    
    
    /*9. int class_getVersion(Class cls) ：获取类的版本号，默认都是0
     void class_setVersion(Class cls, int version) :修改某个类的版本号
     */
    int PigVersion = class_getVersion([Pig class]);
    int UIcolorVersion = class_getVersion([UIColor class]);
    NSLog(@"Pig class version is %d",PigVersion);
    NSLog(@"UIcolor class version is %d",UIcolorVersion);
    
    class_setVersion([Pig class], 777);
    class_setVersion([UIColor class], 888);
    int PigVersionSet = class_getVersion([Pig class]);
    int UIcolorVersionSet = class_getVersion([UIColor class]);
    NSLog(@"Pig class version is %d",PigVersionSet);
    NSLog(@"UIcolor class version is %d",UIcolorVersionSet);
    
    
    /*10. Ivar class_getClassVariable(Class cls, const char *name) : cls 类的变量名为 name 的变量
     目前已知的类的变量名只有一个 isa，返回值是参数 cls 的元类*/
    Ivar viewIvar = class_getClassVariable([UIView class], "isa");
    id getViewIvar = object_getIvar([UIView class], viewIvar);
    NSLog(@"%d", class_isMetaClass(getViewIvar));
    NSLog(@"%@", getViewIvar);
    
    Ivar pigIvar = class_getClassVariable([Pig class], "pigColor");
    id getPigIvar = object_getIvar([Pig class], pigIvar);
    NSLog(@"%d", class_isMetaClass(getPigIvar));
    NSLog(@"%@", getPigIvar);
    
    
    /*11. Method class_getInstanceMethod(Class cls, SEL name) :获取 cls 类的名为 name 的实例方法。如果参数 name 传入 cls 类的类方法则返回空，传入其他类的方法也返回空。
     其中 method_getName 和 sel_getName 函数的作用是获取方法名称
     */
    Method mth1 = class_getInstanceMethod([UIButton class], @selector(setImage:forState:)); // UIButton 的实例方法
    SEL sel1 = method_getName(mth1);
    NSLog(@"%s", sel_getName(sel1));
    
    Method mth2 = class_getInstanceMethod([UIButton class], @selector(buttonWithType:)); // UIButton 的类方法
    SEL sel2 = method_getName(mth2);
    NSLog(@"%s", sel_getName(sel2));
    
    Method mth3 = class_getInstanceMethod([UIButton class], @selector(imageNamed:)); // UIImage 的类方法
    SEL sel3 = method_getName(mth3);
    NSLog(@"%s", sel_getName(sel3));
    
    
    /*12. Method class_getClassMethod(Class cls, SEL name) 获取 cls 类的名为 name 的类方法。如果参数 name 传入 cls 类的实例方法则返回空，传入其他类的方法也返回空。*/
    Method mth1_Class = class_getClassMethod([UIColor class], @selector(colorWithWhite:alpha:)); // UIColor 的类方法
    SEL sel1_Class = method_getName(mth1_Class);
    NSLog(@"%s", sel_getName(sel1_Class));
    
    Method mth2_Class = class_getClassMethod([UIColor class], @selector(initWithWhite:alpha:)); // UIColor 的实例方法
    SEL sel2_Class = method_getName(mth2_Class);
    NSLog(@"%s", sel_getName(sel2_Class));
    
    Method mth3_Class = class_getClassMethod([UIButton class], @selector(imageNamed:)); // UIImage 的类方法
    SEL sel3_Class = method_getName(mth3_Class);
    NSLog(@"%s", sel_getName(sel3_Class));
    
    
    /*13. IMP class_getMethodImplementation(Class cls, SEL name) 获取 cls 类的名为 name 方法的实现*/
    IMP imp = class_getMethodImplementation([UIView class], @selector(animateWithDuration:animations:completion:));
    IMP imp2 = class_getMethodImplementation([UIView class], @selector(setNeedsDisplay));
    
    
}




@end
