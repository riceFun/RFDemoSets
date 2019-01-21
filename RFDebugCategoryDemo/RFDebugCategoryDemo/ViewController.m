//
//  ViewController.m
//  RFDebugCategoryDemo
//
//  Created by riceFun on 2018/12/6.
//  Copyright © 2018 riceFun. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // 并发队列
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    NSArray * array = @[@"d",@"s",@"d",@"a",@"f",@"g",@"h",@" ",@"y",@"j"];
    //dispatch_apply 快速迭代（遍历）
    dispatch_apply(array.count, queue, ^(size_t index) {
        NSLog(@"currentIndex:%zu currentValue:%@",index,array[index]);
    });
    
    
    
    dispatch_group_t group =  dispatch_group_create();
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"队列组：前面的耗时操作都完成了，回到主线程进行相关操作");
    });
    
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        NSLog(@"队列组：A有一个耗时操作完成！");
        for (int i = 0; i < 3; i++) {
            NSLog(@"队列组：A并发异步   %@",[NSThread currentThread]);
        }
    });
    
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        NSLog(@"队列组：B有一个耗时操作完成！");
    });
    
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        NSLog(@"队列组：C有一个耗时操作完成！");
        for (int i = 0; i < 3; i++) {
            NSLog(@"队列组：C并发异步   %@",[NSThread currentThread]);
        }
    });
    
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        NSLog(@"队列组：D有一个耗时操作完成！");
    });
    
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        NSLog(@"队列组：E有一个耗时操作完成！");
    });
    
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        NSLog(@"队列组：F有一个耗时操作完成！");
    });
    



    
    return;
    
    [DebugCategoryManager get_NSArray_objectAtIndex_tureClass];
    
    NSArray *debugArray = @[@"f",@"f",@"f",@"f"];
    NSString *p = [debugArray objectAtIndex:4];
    
    [DebugCategoryManager get_object_methodListWith:@"__NSArrayI"];
    
}

-(void)kkk{
    
}

@end
