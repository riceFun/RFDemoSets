//
//  ComplexFuncSetsViewController.m
//  RFRuntimeDemo
//
//  Created by riceFun on 2018/12/14.
//  Copyright © 2018 riceFun. All rights reserved.
//

#import "ComplexFuncSetsViewController.h"
#import <objc/runtime.h>

@interface ComplexFuncSetsViewController ()
@property (nonatomic,strong) UITextField *textField;

@end

@implementation ComplexFuncSetsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    /*1. id object_getIvar(id obj, Ivar ivar)
     //分析：Ivar：instanceVariable（实例变量）
     函数说明：reads the value of an instacne variable in an object. 即获取一个对象obj的实例变量ivar的值。要使用这个函数，首先需要一个Ivar,我们使用class_copyIvarList 函数获取一个Ivar 数组从而获取一个Ivar
     */
    
    
    /*2. Ivar *class_copyIvarList(Class cls, unsigned int *outCount) :该函数的作用是获取传入类的所有实例变量，返回的是实例变量数组*/
    unsigned int outCount;//1
    Ivar *ivars = class_copyIvarList([UITextField class], &outCount);//2
    for (int i = 0; i < outCount; i++) {//3
        Ivar ivar = ivars[i];//4 获取到Ivar后可以利用 ivar_getName 函数获取 Ivar 的名称，用 ivar_getTypeEncoding 函数获取 Ivar 的类型编码，通过类型编码就可以知道该 Ivar 是何种类型的。
        const char *ivarName = ivar_getName(ivar); // 5
        const char *ivarType = ivar_getTypeEncoding(ivar); // 6
        NSLog(@"实例变量名为：%s 字符串类型为：%s", ivarName, ivarType); // 7
    }//8
    
    free(ivars);//9 由于ARC只适用于Foundation等框架，对于Core Foundation 和 runtime 等并不适用，所以在使用带有copy、retain等字样的函数或方法时需要手动释放free()。
    
    //使用场景：方便地更改UITextField了，比如更改UITextField的占位字体颜色，使用KVC
    // self.textField就是上图显示的UITextField
    [self.view addSubview:self.textField];
    id value = [self.textField valueForKey:@"_placeholderLabel"]; // 10
    NSLog(@"value class:%@, value superclass:%@", NSStringFromClass([value class]), NSStringFromClass([value superclass])); // 11
    [self.textField setValue:[UIColor orangeColor] forKeyPath:@"_placeholderLabel.textColor"]; // 12 是forKeyPath 而不是key
    
    /*3. Ivar class_getInstanceVariable(Class cls, const char *name)
     此时再回到第一个函数id object_getIvar(id obj, Ivar ivar)的使用方法，
     有了Ivar名称后如果需要再用到该Ivar，就需要用到class_getInstanceVariable函数，该函数是的作用是获取指定类的指定名称的实例变量。
     */
    Ivar ivar = class_getInstanceVariable([UITextField class], "_placeholderLabel");//得到的即是对象self.textField的ivar名称为_placeholderLabel的值。
    id getIvar = object_getIvar(self.textField, ivar);//拿到placeholderLabel 这个实例变量
    NSLog(@"%@", getIvar);
    //打印：<UITextFieldLabel: 0x7fdce960b610; frame = (0 0; 0 0); text = '请输入'; opaque = NO; userInteractionEnabled = NO; layer = <_UILabelLayer: 0x600002da46e0>>
   
}


-(UITextField *)textField{
    if (!_textField) {
        _textField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 300, 50)];
        _textField.center = self.view.center;
        _textField.borderStyle = UITextBorderStyleRoundedRect;
        _textField.placeholder = @"请输入";
    }
    return _textField;
}


@end
