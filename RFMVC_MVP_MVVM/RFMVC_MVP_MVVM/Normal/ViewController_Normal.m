//
//  ViewController_Normal.m
//  RFMVC_MVP_MVVM
//
//  Created by riceFun on 2019/1/2.
//  Copyright © 2019 riceFun. All rights reserved.
//

#import "ViewController_Normal.h"
#import "UserInfoView_Normal.h"
#import "BlogCell_Normal.h"

@interface ViewController_Normal ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UserInfoView_Normal *tableHeaderView_UserInfo;
@property (nonatomic,strong) UITableView *tableView_Normal;
@property (nonatomic,strong) NSArray *bolgArray;

@end

@implementation ViewController_Normal

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    
    [self requestData];
}

- (void)setupUI{
    self.title = NSStringFromClass([self class]);
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView_Normal];
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    [self.tableView_Normal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top);
        make.right.mas_equalTo(self.view.mas_right);
        make.left.mas_equalTo(self.view.mas_left);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
}

- (void)requestData{
    [SVProgressHUD show];
    [RFNetWorkManager fetchUserInfoWithUserId:@"1" completionHandler:^(NSError * _Nonnull error, id  _Nonnull result) {
        [SVProgressHUD dismiss];
        if (error) {
            [SVProgressHUD showErrorWithStatus:@"获取用户信息失败了~"];
        } else {
            self.tableHeaderView_UserInfo.userInfo = result;
        }
    }];
    
    [RFNetWorkManager fetchUserBlogsWithUserId:@"1" completionHandler:^(NSError * _Nonnull error, id  _Nonnull result) {
        [SVProgressHUD dismiss];
        if (error) {
            [SVProgressHUD showErrorWithStatus:@"获取用户信息失败了~"];
        } else {
            self.bolgArray = result;
            [self.tableView_Normal reloadData];;
        }
    }];
}

#pragma mark delegate&dataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.bolgArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BlogCell_Normal *cell = [BlogCell_Normal cellWithTableView:tableView];
    cell.blog = self.bolgArray[indexPath.row];
    __weak typeof(cell) weakCell = cell;
    __weak typeof(tableView) weakTableView = tableView;
    cell.likeBlock = ^{
        weakCell.blog.likeNum += 1;
        [weakTableView reloadData];
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [self.navigationController pushViewController:[BlogDetailViewController instanceWithBlog:self.blogs[indexPath.row]] animated:YES];
}

#pragma mark getter
-(UserInfoView_Normal *)tableHeaderView_UserInfo{
    if (!_tableHeaderView_UserInfo) {
        _tableHeaderView_UserInfo = [[UserInfoView_Normal alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    }
    return _tableHeaderView_UserInfo;
}

-(UITableView *)tableView_Normal{
    if (!_tableView_Normal) {
        _tableView_Normal = [[UITableView alloc]initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        _tableView_Normal.delegate = self;
        _tableView_Normal.dataSource = self;
        _tableView_Normal.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        _tableView_Normal.tableHeaderView = self.tableHeaderView_UserInfo;
    }
    return _tableView_Normal;
}

-(NSArray *)bolgArray{
    if (!_bolgArray) {
        _bolgArray = [NSArray array];
    }
    return _bolgArray;
}

@end
