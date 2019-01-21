//
//  DraftCell_Normal.m
//  RFMVC_MVP_MVVM
//
//  Created by riceFun on 2019/1/2.
//  Copyright © 2019 riceFun. All rights reserved.
//

#import "DraftCell_Normal.h"
@interface DraftCell_Normal ()
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *detailTitleLabel;
@property (nonatomic,strong) UILabel *dateLabel;
@end

@implementation DraftCell_Normal

+(instancetype)cellWithTableView:(UITableView *)tableView{
    
    NSString *cellID = @"555";
    DraftCell_Normal *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[DraftCell_Normal alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.detailTitleLabel];
        [self.contentView addSubview:self.dateLabel];
        
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
    
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-16);
        make.top.equalTo(self.detailTitleLabel.mas_bottom).offset(5);
        
        make.bottom.mas_lessThanOrEqualTo(self.contentView.mas_bottom).offset(-5);
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

-(UILabel *)dateLabel{
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc]init];
        _dateLabel.font = [UIFont systemFontOfSize:16];
    }
    return _dateLabel;
}

#pragma mark - setter
-(void)setDraft:(Draft *)draft{
    _draft = draft;
    
    self.titleLabel.text = draft.title;
    self.detailTitleLabel.text = draft.detailTitle;
    self.dateLabel.text = draft.dateString;
}



@end
