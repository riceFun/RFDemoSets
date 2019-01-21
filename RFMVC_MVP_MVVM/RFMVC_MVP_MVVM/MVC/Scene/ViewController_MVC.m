//
//  ViewController_MVC.m
//  RFMVC_MVP_MVVM
//
//  Created by riceFun on 2019/1/2.
//  Copyright © 2019 riceFun. All rights reserved.
//

#import "ViewController_MVC.h"

#import "BlogTableViewHelper.h"

@interface ViewController_MVC ()
@property (nonatomic,strong) BlogTableViewHelper *blogTableViewHelper;

@end

@implementation ViewController_MVC

-(instancetype)init{
    if (self = [super init]) {
        self.userId = @"1";
        
        self.blogTableViewHelper = [BlogTableViewHelper initHelperWithUserId:self.userId];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self queryData];
}

-(void)setupUI{
    self.title = NSStringFromClass([self class]);
    self.blogTableViewHelper.helperView.frame = self.view.bounds;
    [self.view addSubview:self.blogTableViewHelper.helperView];
}

-(void)queryData{
    [SVProgressHUD show];
    [self.blogTableViewHelper BlogTableViewHelper_fecthDataWithCompletionHandler:^(NSError * _Nonnull error, id  _Nonnull result) {
        [SVProgressHUD dismiss];
        if (error) {
            [SVProgressHUD showErrorWithStatus:@"数据请求失败"];
        }
    }];
}


@end
