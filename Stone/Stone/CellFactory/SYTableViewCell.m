//
//  SYTableViewCell.m
//  Stone
//
//  Created by Stone.Yu on 2017/6/29.
//  Copyright © 2017年 Stone.Yu. All rights reserved.
//

#import "SYTableViewCell.h"

@implementation SYTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initCell];
        [self addSubViews];
    }
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    NSString *reuseIdentifier = NSStringFromClass([self class]);
    SYTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    return cell;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView cellType:(NSString *)cellClassName
{
    return [self cellWithTableView:tableView cellType:cellClassName delegata:nil];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView cellType:(NSString *)cellClassName
                         delegata:(id)delegate
{
    SYTableViewCell *cell = nil;
    
    if (!cellClassName || !cellClassName.length) {
        return [SYTableViewCell cellWithTableView:tableView];
    }
    
    Class class = NSClassFromString(cellClassName);
    
    if (class && [class isSubclassOfClass:[SYTableViewCell class]]) {
        cell = [class cellWithTableView:tableView];
        cell.delegate = delegate;
    }
    
    if (!cell) {
        cell = [SYTableViewCell cellWithTableView:tableView];
    }
    
    return cell;
}

- (void)initCell { }
- (void)addSubViews { }

- (void)setDelegate:(id<SYTableViewCellDelegate>)delegate
{
    _delegate = delegate;
}

- (void)setCellWithData:(__kindof SYCellModel *)cellModel
{
    self.cellModel = cellModel;
}

@end
