//
//  ViewController.m
//  RFKVODemo
//
//  Created by riceFun on 2018/12/7.
//  Copyright © 2018 riceFun. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import "KVO_Objc.h"

@interface ViewController ()
@property (nonatomic,strong)UIButton *actionBtn;
@property (nonatomic,strong)UILabel *kvoLabel;
@property (nonatomic,strong)KVO_Objc *kvoObjc;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.actionBtn];
    [self.view addSubview:self.kvoLabel];
    
    
    [self runtimeLog];
    /* objectMethodClass : UILabel, ObjectRuntimeClass : UILabel, superClass : UIView*/
    
    //kvoLabel 监视trueLabel
    [self.kvoObjc addObserver:self forKeyPath:@"num" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
    
    NSLog(@"=============================================================================================================");
    
    [self runtimeLog];
    /*
     2018-12-07 16:01:05.125245+0800 RFKVODemo[82349:5119989] objectMethodClass : KVO_Objc, ObjectRuntimeClass : KVO_Objc, superClass : NSObject
     2018-12-07 16:01:05.125378+0800 RFKVODemo[82349:5119989] object method list
     2018-12-07 16:01:05.125475+0800 RFKVODemo[82349:5119989] method Name = setNum:
     2018-12-07 16:01:05.125585+0800 RFKVODemo[82349:5119989] method Name = num
     2018-12-07 16:01:05.125889+0800 RFKVODemo[82349:5119989] =============================================================================================================
     2018-12-07 16:01:05.125979+0800 RFKVODemo[82349:5119989] objectMethodClass : KVO_Objc, ObjectRuntimeClass : NSKVONotifying_KVO_Objc, superClass : KVO_Objc
     2018-12-07 16:01:05.126056+0800 RFKVODemo[82349:5119989] object method list
     2018-12-07 16:01:05.126135+0800 RFKVODemo[82349:5119989] method Name = setNum:
     2018-12-07 16:01:05.126213+0800 RFKVODemo[82349:5119989] method Name = class
     2018-12-07 16:01:05.126285+0800 RFKVODemo[82349:5119989] method Name = dealloc
     2018-12-07 16:01:05.126363+0800 RFKVODemo[82349:5119989] method Name = _isKVOA
     */
    
    //由此可见  在addObserver 后 系统自动生成了NSKVONotifying_KVO_Objc 这么个类，还有增加了_isKVOA 这个方法
}

-(void)runtimeLog{
    unsigned int count;
    Class objectMethodClass = [self.kvoObjc class];
    Class objectRuntimeClass = object_getClass(self.kvoObjc);
    Class superClass = class_getSuperclass(objectRuntimeClass);
    NSLog(@"objectMethodClass : %@, ObjectRuntimeClass : %@, superClass : %@ \n", objectMethodClass, objectRuntimeClass, superClass);
    
    NSLog(@"object method list \n");
    Method *methodList = class_copyMethodList(objectRuntimeClass, &count);
    for (NSInteger i = 0; i < count; i++) {
        Method method = methodList[i];
        NSString *methodName = NSStringFromSelector(method_getName(method));
        NSLog(@"method Name = %@\n", methodName);
    }
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    // 判断是否为self.tureLabel的属性“text”:
    if([keyPath isEqualToString:@"num"] && object == self.kvoObjc) {
        // 响应变化处理：UI更新（label文本改变）
        self.kvoLabel.text = [NSString stringWithFormat:@"%@",[change valueForKey:@"new"]];
        
        NSLog(@"oldText:%@ newText:%@",
              [change valueForKey:@"old"],
              [change valueForKey:@"new"]);
    }
}

#pragma mark userEvent
-(void)click_actionBtn:(UIButton *)btn{
    static int a = 2;
    self.kvoObjc.num = a;
    a ++;
}

#pragma mark getter
-(UIButton *)actionBtn{
    if (!_actionBtn) {
        _actionBtn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 40)];
        [_actionBtn setBackgroundColor:[UIColor lightGrayColor]];
        [_actionBtn setTitle:@"click me" forState:UIControlStateNormal];
        [_actionBtn addTarget:self action:@selector(click_actionBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _actionBtn;
}

-(UILabel *)kvoLabel{
    if (!_kvoLabel) {
        _kvoLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 220, 100, 40)];
        _kvoLabel.backgroundColor = [UIColor darkGrayColor];
        _kvoLabel.textColor = [UIColor whiteColor];
    }
    return _kvoLabel;
}

-(KVO_Objc *)kvoObjc{
    if (!_kvoObjc) {
        _kvoObjc = [[KVO_Objc alloc]init];
    }
    return _kvoObjc;
}

-(void)dealloc{
    [self.kvoObjc removeObserver:self forKeyPath:@"num"];
}

@end
