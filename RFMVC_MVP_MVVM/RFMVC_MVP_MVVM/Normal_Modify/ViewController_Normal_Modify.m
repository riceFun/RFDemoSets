//
//  ViewController_Normal_Modify.m
//  RFMVC_MVP_MVVM
//
//  Created by riceFun on 2019/1/2.
//  Copyright © 2019 riceFun. All rights reserved.
//

#import "ViewController_Normal_Modify.h"
#import "UserInfoView_Normal_Modify.h"
#import "BlogCell_Normal.h"
#import "DraftCell_Normal.h"

@interface ViewController_Normal_Modify ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UserInfoView_Normal_Modify *tableHeaderView_UserInfo;
@property (nonatomic,strong) UITableView *tableView_Normal;
@property (nonatomic,strong) NSArray *bolgArray;
@property (nonatomic,strong) NSArray *draftArray;

@property (nonatomic,assign) BOOL isUserSelf;

@end

@implementation ViewController_Normal_Modify

- (void)viewDidLoad {
    [super viewDidLoad];
    [self dataInit];
    
    [self setupUI];
    
//    [self requestData];
    //使用动作代替 网络请求
    [self click_segmentControl:self.tableHeaderView_UserInfo.segmentControl];
    
}

static int a = 0;
- (void)dataInit{
    if (a % 2 == 0) {
        self.isUserSelf = YES;
    }else{
        self.isUserSelf = NO;
    }
    a ++;
    
}

- (void)setupUI{
    self.title = NSStringFromClass([self class]);
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView_Normal];
    if (self.isUserSelf) {
        self.tableHeaderView_UserInfo.frame = CGRectMake(0, 0, self.view.frame.size.width, 240);
        self.tableHeaderView_UserInfo.segmentControl.hidden = NO;
    }else{
        self.tableHeaderView_UserInfo.frame = CGRectMake(0, 0, self.view.frame.size.width, 200);
        self.tableHeaderView_UserInfo.segmentControl.hidden = YES;
    }
    
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
    
    if (self.tableHeaderView_UserInfo.segmentControl.selectedSegmentIndex == 0) {
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
    }else{
        [RFNetWorkManager fetchUserInfoWithUserId:@"1" completionHandler:^(NSError * _Nonnull error, id  _Nonnull result) {
            [SVProgressHUD dismiss];
            if (error) {
                [SVProgressHUD showErrorWithStatus:@"获取用户信息失败了~"];
            } else {
                self.tableHeaderView_UserInfo.userInfo = result;
            }
        }];
        
        [RFNetWorkManager fetchUserDraftsWithUserId:@"1" completionHandler:^(NSError * _Nonnull error, id  _Nonnull result) {
            [SVProgressHUD dismiss];
            if (error) {
                [SVProgressHUD showErrorWithStatus:@"获取用户信息失败了~"];
            } else {
                self.draftArray = result;
                [self.tableView_Normal reloadData];;
            }
        }];
    }
}

#pragma mark delegate&dataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.tableHeaderView_UserInfo.segmentControl.selectedSegmentIndex == 0) {
        return self.bolgArray.count;
    }else{
        return self.draftArray.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.tableHeaderView_UserInfo.segmentControl.selectedSegmentIndex == 0) {
        BlogCell_Normal *cell = [BlogCell_Normal cellWithTableView:tableView];
        cell.blog = self.bolgArray[indexPath.row];
        __weak typeof(cell) weakCell = cell;
        __weak typeof(tableView) weakTableView = tableView;
        cell.likeBlock = ^{
            weakCell.blog.likeNum += 1;
            [weakTableView reloadData];
        };
        return cell;
    }else{
        DraftCell_Normal *cell = [DraftCell_Normal cellWithTableView:tableView];
        Draft *draft = self.draftArray[indexPath.row];
        cell.draft = draft;
        return cell;
    }    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.tableHeaderView_UserInfo.segmentControl.selectedSegmentIndex == 0) {
        //    [self.navigationController pushViewController:[BlogDetailViewController instanceWithBlog:self.blogs[indexPath.row]] animated:YES];
    }else{
        //    [self.navigationController pushViewController:[DraftDetailViewController instanceWithBlog:self.blogs[indexPath.row]] animated:YES];
    }
}

#pragma mark getter
-(UserInfoView_Normal_Modify *)tableHeaderView_UserInfo{
    if (!_tableHeaderView_UserInfo) {
        _tableHeaderView_UserInfo = [[UserInfoView_Normal_Modify alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
        [_tableHeaderView_UserInfo.segmentControl addTarget:self action:@selector(click_segmentControl:) forControlEvents:UIControlEventValueChanged];
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

-(NSArray *)draftArray{
    if (!_draftArray) {
        _draftArray = [NSArray array];
    }
    return _draftArray;
}

#pragma mark userevent
-(void)click_segmentControl:(UISegmentedControl *)segmentedControl{
    [self requestData];
}

@end
