//
//  BlogCell_MVC.m
//  RFMVC_MVP_MVVM
//
//  Created by riceFun on 2019/1/4.
//  Copyright © 2019 riceFun. All rights reserved.
//

#import "BlogCell_MVC.h"

@implementation BlogCell_MVC
+(instancetype)cellWithTableView:(UITableView *)tableView{
    
    NSString *cellID = @"3434";
    BlogCell_MVC *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[BlogCell_MVC alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.detailTitleLabel];
        [self.contentView addSubview:self.likeBtn];
        [self.contentView addSubview:self.dislikeBtn];
        
        [self configLayout];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

- (void)configLayout{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(5);
        make.left.equalTo(self.contentView.mas_left).offset(16);
        make.right.equalTo(self.contentView.mas_right).offset(-16);
    }];
    
    [self.detailTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(5);
        make.left.equalTo(self.contentView.mas_left).offset(16);
        make.right.equalTo(self.contentView.mas_right).offset(-16);
    }];
    
    [self.dislikeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-16);
        make.top.equalTo(self.detailTitleLabel.mas_bottom).offset(5);
        
        make.bottom.mas_lessThanOrEqualTo(self.contentView.mas_bottom).offset(-5);
    }];
    
    [self.likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.dislikeBtn.mas_centerY);
        make.right.equalTo(self.dislikeBtn.mas_left).offset(-16);
    }];
    
}


#pragma mark - getter
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:18];
    }
    return _titleLabel;
}

-(UILabel *)detailTitleLabel{
    if (!_detailTitleLabel) {
        _detailTitleLabel = [[UILabel alloc]init];
        _detailTitleLabel.font = [UIFont systemFontOfSize:16];
    }
    return _detailTitleLabel;
}

-(UIButton *)likeBtn{
    if (!_likeBtn) {
        _likeBtn = [[UIButton alloc]init];
        [_likeBtn setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
        [_likeBtn addTarget:self action:@selector(clikc_likeBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _likeBtn;
}

-(UIButton *)dislikeBtn{
    if (!_dislikeBtn) {
        _dislikeBtn = [[UIButton alloc]init];
        [_dislikeBtn setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
    }
    return _dislikeBtn;
}

#pragma mark - setter
//-(void)setBlog:(Blog *)blog{
//    _blog = blog;
//
//    self.titleLabel.text = blog.title;
//    self.detailTitleLabel.text = blog.detailTitle;
//    [self.likeBtn setTitle:[NSString stringWithFormat:@"👍：%d",blog.likeNum] forState:(UIControlStateNormal)];
//    [self.dislikeBtn setTitle:[NSString stringWithFormat:@"踩：%d",blog.dislikeNum] forState:(UIControlStateNormal)];
//}

#pragma mark userEvent
-(void)clikc_likeBtn:(UIButton *)btn{
    if (self.likeBlock) {
        self.likeBlock();
    }
}

@end


