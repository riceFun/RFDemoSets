//
//  DraftCell_Normal.h
//  RFMVC_MVP_MVVM
//
//  Created by riceFun on 2019/1/2.
//  Copyright © 2019 riceFun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DraftCell_Normal : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic,strong) Draft *draft;

@end

NS_ASSUME_NONNULL_END
