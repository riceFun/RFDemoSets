//
//  BlogCell_Normal.h
//  RFMVC_MVP_MVVM
//
//  Created by riceFun on 2019/1/2.
//  Copyright © 2019 riceFun. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^BlogCell_NormalLikeBlock) (void);

@interface BlogCell_Normal : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic,strong) Blog *blog;
@property (nonatomic,copy) BlogCell_NormalLikeBlock likeBlock;

@end

NS_ASSUME_NONNULL_END
