//
//  ViewController.m
//  RFRunLoopDemo
//
//  Created by riceFun on 2018/12/18.
//  Copyright © 2018 riceFun. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        while (1) {
            NSLog(@"while begin");
            NSRunLoop *subRunLoop = [NSRunLoop currentRunLoop];
            [subRunLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
            NSLog(@"while end");
        }
    });
    
    
    
   
    
//    NSMutableString *a = [NSMutableString stringWithString:@"Tom"];
//    NSLog(@"\\n 定以前：------------------------------------\\n\\a指向的堆中地址：%p；a在栈中的指针地址：%p", a, &a);               //a在栈区
//    void (^foo)(void) = ^{
//          a.string = @"Jerry";
//          NSLog(@"\\n block内部：------------------------------------\\n\\a指向的堆中地址：%p；a在栈中的指针地址：%p", a, &a);               //a在栈区
//        a = [NSMutableString stringWithString:@"William"];
//    };
//    foo();
//    NSLog(@"\\n 定以后：------------------------------------\\n\\a指向的堆中地址：%p；a在栈中的指针地址：%p", a, &a);
    
                         
    
    
    //创建监听者
    /*
     第一个参数 CFAllocatorRef allocator：分配存储空间 CFAllocatorGetDefault()默认分配
     第二个参数 CFOptionFlags activities：要监听的状态 kCFRunLoopAllActivities 监听所有状态
     第三个参数 Boolean repeats：YES:持续监听 NO:不持续
     第四个参数 CFIndex order：优先级，一般填0即可
     第五个参数 ：回调 两个参数observer:监听者 activity:监听的事件
     */
    /*
     所有事件
     typedef CF_OPTIONS(CFOptionFlags, CFRunLoopActivity) {
     kCFRunLoopEntry = (1UL << 0),   //   即将进入RunLoop
     kCFRunLoopBeforeTimers = (1UL << 1), // 即将处理Timer
     kCFRunLoopBeforeSources = (1UL << 2), // 即将处理Source
     kCFRunLoopBeforeWaiting = (1UL << 5), //即将进入休眠
     kCFRunLoopAfterWaiting = (1UL << 6),// 刚从休眠中唤醒
     kCFRunLoopExit = (1UL << 7),// 即将退出RunLoop
     kCFRunLoopAllActivities = 0x0FFFFFFFU
     };
     */
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        switch (activity) {
            case kCFRunLoopEntry:
                NSLog(@"RunLoop进入");
                break;
            case kCFRunLoopBeforeTimers:
                NSLog(@"RunLoop要处理Timers了");
                break;
            case kCFRunLoopBeforeSources:
                NSLog(@"RunLoop要处理Sources了");
                break;
            case kCFRunLoopBeforeWaiting:
                NSLog(@"RunLoop要休息了");
                break;
            case kCFRunLoopAfterWaiting:
                NSLog(@"RunLoop醒来了");
                break;
            case kCFRunLoopExit:
                NSLog(@"RunLoop退出了");
                break;
                
            default:
                break;
        }
    });
    
    // 给RunLoop添加监听者
    /*
     第一个参数 CFRunLoopRef rl：要监听哪个RunLoop,这里监听的是主线程的RunLoop
     第二个参数 CFRunLoopObserverRef observer 监听者
     第三个参数 CFStringRef mode 要监听RunLoop在哪种运行模式下的状态
     */
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopDefaultMode);
    /*
     CF的内存管理（Core Foundation）
     凡是带有Create、Copy、Retain等字眼的函数，创建出来的对象，都需要在最后做一次release
     GCD本来在iOS6.0之前也是需要我们释放的，6.0之后GCD已经纳入到了ARC中，所以我们不需要管了
     */
    CFRelease(observer);
    
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    // 当前触摸点，设置以自己为参照，坐标原点为自己（self）的左上角
    CGPoint current = [touch locationInView:self.view];
    // 上一个触摸点
    CGPoint previous = [touch previousLocationInView:self.view];
    
    // 修改当前view的位置(中点)
    CGPoint center = self.view.center;
    center.x += current.x - previous.x;
    center.y += current.y - previous.y;
    self.view.center = center;
}




@end
