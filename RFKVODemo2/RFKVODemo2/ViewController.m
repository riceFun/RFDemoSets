//
//  ViewController.m
//  RFKVODemo2
//
//  Created by riceFun on 2018/12/13.
//  Copyright © 2018 riceFun. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+Hook.h"
#import "Dog.h"
#import "Cat.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    Dog *dog = [[Dog alloc]init];
//    [dog eat];
//
//    NSLog(@"======================================================================");
//    [ViewController hookWithInstance:dog method:@selector(eat) newclass:[Cat class]];
//
//    [dog eat];
    
    
    [Dog drink];
    
    NSLog(@"======================================================================");
    [ViewController hookWithInstance:[Dog class] method:@selector(drink) newclass:[Cat class]];
    
    [Dog drink];
    
}


@end
