//
//  SYTableViewCell.m
//  Stone
//
//  Created by Stone.Yu on 2017/6/29.
//  Copyright © 2017年 Stone.Yu. All rights reserved.
//

#import "SYTableViewCell.h"

@implementation SYTableViewCell

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

+ (instancetype)cellWithTableView:(UITableView *)tableView cellType:(NSString *)cellClassString
{
    return [self cellWithTableView:tableView cellType:cellClassString delegata:nil];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView cellType:(NSString *)cellClassString
                         delegata:(id)delegate
{
    SYTableViewCell *cell = nil;
    
    if (!cellClassString || !cellClassString.length) {
        return [SYTableViewCell cellWithTableView:tableView];
    }
    
    Class class = NSClassFromString(cellClassString);
    
    if (class && [class isSubclassOfClass:[SYTableViewCell class]]) {
        cell = [class cellWithTableView:tableView];
        cell.delegate = delegate;
    }
    
    if (!cell) {
        cell = [SYTableViewCell cellWithTableView:tableView];
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubViews];
    }
    
    return self;
}

- (void)addSubViews { }

- (void)setDelegate:(id<SYTableViewCellDelegate>)delegate
{
    _delegate = delegate;
}

- (void)setCellWithData:(__kindof SYCellModel *)cellModel
{
    if (!cellModel) {
        return;
    }
    
    self.cellModel = cellModel;
}

@end
