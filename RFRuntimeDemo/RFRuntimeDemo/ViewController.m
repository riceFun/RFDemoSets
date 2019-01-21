//
//  ViewController.m
//  RFRuntimeDemo
//
//  Created by riceFun on 2018/12/13.
//  Copyright © 2018 riceFun. All rights reserved.
//

#import "ViewController.h"
#import "ObjcGetSetClassViewController.h"
#import "SimpleFunctionSetsViewController.h"
#import "ComplexFuncSetsViewController.h"
#import "Object_setIvarViewController.h"
#import "Objc_getClassList_copyClassListViewController.h"
#import "Class_getInstanceSizeViewController.h"
#import "SelectorViewController.h"
#import "Class_copyMethodListViewController.h"
#import "ProtocolViewController.h"
#import "PropertyViewController.h"
#import "IvarLayout_WeakIvarLayoutViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *dataArray;
@property (nonatomic,strong) NSArray *vcArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"RFRuntimeDemo";
    [self.view addSubview:self.tableView];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dsds"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"dsds"];
        cell.textLabel.numberOfLines = 99;
        cell.textLabel.font = [UIFont systemFontOfSize:14];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *vcName = self.vcArray[indexPath.row];
    UIViewController *vc = [NSClassFromString(vcName) new];
    vc.title = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    }
    return _tableView;
}

-(NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray = @[
                       @"object_getClass 和 object_setClass",
                       @"一些简单的函数集合",
                       @"object_getIvar、class_copyIvarList、ivar_getName、ivar_getTypeEncoding 和 class_getInstanceVariable",
                       @"Object_setIvar",
                       @"objc_getClassList 和 objc_copyClassList",
                       @"class_getInstanceSize 和 苹果对内存的优化",
                       @"class_respondsToSelector 、respondsToSelector 和 instancesRespondToSelector",
                       @"Class_copyMethodList",
                       @"Protocol",
                       @"Property",
                       @"class_getIvarLayout 和 class_getWeakIvarLayout,"
                       ];
    }
    return _dataArray;
}

-(NSArray *)vcArray{
    if (!_vcArray) {
        _vcArray = @[
                     @"ObjcGetSetClassViewController",
                     @"SimpleFunctionSetsViewController",
                     @"ComplexFuncSetsViewController",
                     @"Object_setIvarViewController",
                     @"Objc_getClassList_copyClassListViewController",
                     @"Class_getInstanceSizeViewController",
                     @"SelectorViewController",
                     @"Class_copyMethodListViewController",
                     @"ProtocolViewController",
                     @"PropertyViewController",
                     @"IvarLayout_WeakIvarLayoutViewController",
                     ];
    }
    return _vcArray;
}

@end
