//
//  main.m
//  RFRunLoopDemo
//
//  Created by riceFun on 2018/12/18.
//  Copyright © 2018 riceFun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
//        NSLog(@"55555");
//        sleep(5);
//        NSLog(@"666");
//        return 9;//if return, application will be kill 只要return 程序就会被杀死，退出
        int a = UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));//这个函数内部 启动了一个runloop 所以 才一直没有返回，程序也就一直运行着
        return a;
    }
}
