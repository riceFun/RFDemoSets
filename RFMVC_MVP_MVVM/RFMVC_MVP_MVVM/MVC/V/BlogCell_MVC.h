//
//  BlogCell_MVC.h
//  RFMVC_MVP_MVVM
//
//  Created by riceFun on 2019/1/4.
//  Copyright © 2019 riceFun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BlogCellHelper.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^BlogCell_MVC_NormalLikeBlock) (void);

@interface BlogCell_MVC : UITableViewCell
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *detailTitleLabel;
@property (nonatomic,strong) UIButton *likeBtn;
@property (nonatomic,strong) UIButton *dislikeBtn;
@property (nonatomic,copy) BlogCell_MVC_NormalLikeBlock likeBlock;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
