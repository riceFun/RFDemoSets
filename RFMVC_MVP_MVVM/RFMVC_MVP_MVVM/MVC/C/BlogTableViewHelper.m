//
//  BlogTableViewHelper.m
//  RFMVC_MVP_MVVM
//
//  Created by riceFun on 2019/1/3.
//  Copyright © 2019 riceFun. All rights reserved.
//

#import "BlogTableViewHelper.h"
#import "BlogCellHelper.h"
#import "BlogCell_MVC.h"

@interface BlogTableViewHelper ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *blogTableView;
@property (nonatomic,strong) UserInfoViewHelper *userInfoViewHelper;
@property (nonatomic,copy) NSString *userId;
@property (nonatomic,strong)NSMutableArray *blogCellHelperArray;

@end

@implementation BlogTableViewHelper
+(instancetype)initHelperWithUserId:(NSString *)userId{
    return [[BlogTableViewHelper alloc] initWithUserId:userId];
}

-(instancetype)initWithUserId:(NSString *)userId{
    if (self = [super init]) {
        self.userId = userId;
        
        self.userInfoViewHelper = [UserInfoViewHelper initHelperWithUserId:userId];
        [self blogTableView];
        
        [self configLayout];
    }
    return self;
}

-(void)configLayout{
    if ([self.userId isEqualToString:USER_SELF_ID]) {
        self.userInfoViewHelper.helperView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200);
    }else{
        self.userInfoViewHelper.helperView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 240);
    }
}

-(UIView *)helperView{
    return [self blogTableView];
}

#pragma mark network
-(void)BlogTableViewHelper_fecthDataWithCompletionHandler:(NetWorkCompletionHandler)completionHandler{
    
    [self.userInfoViewHelper UserInfoViewHelper_fecthDataWithCompletionHandler:^(NSError * _Nonnull error, id  _Nonnull result) {
        
    }];
    
    
    [RFNetWorkManager fetchUserBlogsWithUserId:self.userId completionHandler:^(NSError * _Nonnull error, id  _Nonnull result) {
        [SVProgressHUD dismiss];
        if (error) {
            [SVProgressHUD showErrorWithStatus:@"获取用户信息失败了~"];
        } else {
            [self.blogCellHelperArray removeAllObjects];
            for (Blog *blog in result) {
                BlogCellHelper *blogCellHelper = [BlogCellHelper helperWithBlog:blog];
                [self.blogCellHelperArray addObject:blogCellHelper];
            }
            [self.blogTableView  reloadData];
        }
    }];
}

#pragma mark delegate && dataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.blogCellHelperArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BlogCell_MVC *cell = [BlogCell_MVC cellWithTableView:tableView];
    
    BlogCellHelper *blogCellHelper = self.blogCellHelperArray[indexPath.row];
    
    cell.titleLabel.text = blogCellHelper.title;
    cell.detailTitleLabel.text = blogCellHelper.detailTitle;
    [cell.likeBtn setTitle:blogCellHelper.likeText forState:(UIControlStateNormal)];
    [cell.dislikeBtn setTitle:blogCellHelper.dislikeText forState:(UIControlStateNormal)];

    __weak typeof(blogCellHelper) weakblogCellHelper = blogCellHelper;
    __weak typeof(tableView) weakTableView = tableView;
    blogCellHelper.likeBlockblock = ^{
        [weakTableView reloadData];
    };
    cell.likeBlock = ^{
        [weakblogCellHelper likeThisBlog];
    };
    return cell;
}

#pragma mark getter
-(UITableView *)blogTableView{
    if (!_blogTableView) {
        _blogTableView = [[UITableView alloc]init];
        _blogTableView.dataSource = self;
        _blogTableView.dataSource = self;
        _blogTableView.tableHeaderView = [self.userInfoViewHelper helperView];
    }
    return _blogTableView;
}

-(NSMutableArray *)blogCellHelperArray{
    if (!_blogCellHelperArray) {
        _blogCellHelperArray = [[NSMutableArray alloc]init];
    }
    return _blogCellHelperArray;
}
@end
