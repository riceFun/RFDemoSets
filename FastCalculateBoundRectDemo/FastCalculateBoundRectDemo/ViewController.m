//
//  ViewController.m
//  FastCalculateBoundRectDemo
//
//  Created by riceFun on 2019/1/22.
//  Copyright © 2019 riceFun. All rights reserved.
//

#import "ViewController.h"
#import "RFStringCalculateManager.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self oldWay:1];
    [self newWay:1];
    
    NSLog(@"\n======================================================================================");
    [self oldWay:10];
    [self newWay:10];
    
    NSLog(@"\n======================================================================================");
    
    [self oldWay:100];
    [self newWay:100];
    
    NSLog(@"\n======================================================================================");
    
    [self oldWay:1000];
    [self newWay:1000];
    
    NSLog(@"\n======================================================================================");

    [self oldWay:10000];
    [self newWay:10000];
    
    NSLog(@"\n======================================================================================");
    
    [self oldWay:100000];
    [self newWay:100000];
    
    NSLog(@"\n======================================================================================");

    [self oldWay:1000000];
    [self newWay:1000000];
    
    NSLog(@"\n======================================================================================");
    
    NSLog(@"测试完成");
}


-(void)oldWay:(int)times{
    NSDictionary *attrs  = [NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:20] forKey:NSFontAttributeName];
    CGSize constraintRect = CGSizeMake(100, 60);
    CGRect rect = CGRectZero;
    NSString *title = @"";
//    NSLog(@"oldWay开始计算了");
    CFTimeInterval startTime = CFAbsoluteTimeGetCurrent();
    for (int i = 0; i < times; i ++) {
        title = [NSString stringWithFormat:@"iOS性能优化之计算多行Label高度的新方法%d",i];
        rect = [title boundingRectWithSize:constraintRect options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil];
    }
    
    CFTimeInterval duration = (CFAbsoluteTimeGetCurrent() - startTime) * 1000.0;
    NSLog(@"oldWay rect:%@", NSStringFromCGRect(rect));
    NSLog(@"使用oldWay计算%d次，总耗时%f ms",times,duration);
    
}

-(void)newWay:(int)times{
    CGSize constraintRect = CGSizeMake(100, 60);
    CGRect rect = CGRectZero;
    NSString *title = @"";
//    NSLog(@"newWay开始计算了");
    CFTimeInterval startTime = CFAbsoluteTimeGetCurrent();
    
    for (int i = 0; i < times; i ++) {
        title = [NSString stringWithFormat:@"iOS性能优化之计算多行Label高度的新方法%d",i];
        rect = [[RFStringCalculateManager sharedInstance] fastCalculateSizeWithString:title maxSize:constraintRect font:[UIFont systemFontOfSize:20]];
    }
    
    CFTimeInterval duration = (CFAbsoluteTimeGetCurrent() - startTime) * 1000.0;
    NSLog(@"newWay rect:%@", NSStringFromCGRect(rect));
    NSLog(@"使用newWay计算%d次，总耗时%f ms",times,duration);    
}


@end
