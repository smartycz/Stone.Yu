//
//  SYTableViewCell2.m
//  Stone
//
//  Created by Stone.Yu on 2017/6/29.
//  Copyright © 2017年 Stone.Yu. All rights reserved.
//

#import "SYTableViewCell2.h"

@interface SYTableViewCell2 ()

@property (nonatomic, strong) UILabel *label1;
@property (nonatomic, strong) UILabel *label2;
@property (nonatomic, strong) UILabel *label3;

@end

@implementation SYTableViewCell2

- (void)addSubViews
{
    [self.contentView addSubview:({
        self.label1 = [UILabel labelWithTextFont:[UIFont H14Font] textColor:[UIColor colorWithHex:0xcccccc] backgroundColor:[UIColor grayColor]];
        [self.label1 setLayerCordius:2.0];
        self.label1;
    })];
    
    [self.contentView addSubview:({
        self.label2 = [UILabel labelWithTextFont:[UIFont H14Font] textColor:[UIColor colorWithHex:0xbbbbbb] backgroundColor:[UIColor grayColor]];
        [self.label2 setLayerCordius:2.0];
        self.label2;
    })];
    
    [self.contentView addSubview:({
        self.label3 = [UILabel labelWithTextFont:[UIFont H14Font] textColor:[UIColor colorWithHex:0xaaaaaa] backgroundColor:[UIColor grayColor]];
        [self.label3 setLayerCordius:2.0];
        self.label3;
    })];
}

- (void)setCellWithData:(__kindof SYCellModel *)cellModel
{
    [super setCellWithData:cellModel];
    
    if (!cellModel.cellContent || ![cellModel.cellContent isKindOfClass:[NSArray class]]) {
        return;
    }
    
    NSArray *contents = cellModel.cellContent;
    
    self.label1.text = contents[0];
    [self.label1 sizeToFit];
    
    self.label2.text = contents[1];
    [self.label2 sizeToFit];
    
    self.label3.text = contents[2];
    [self.label3 sizeToFit];
    
    [self layoutIfNeeded];
}

- (void)layoutSubviews
{
    self.label1.left = (Screen_Width - self.label1.width - self.label2.width - self.label3.width - 20) / 3;
    self.label2.left = self.label1.right + 10;
    self.label3.left = self.label2.right + 10;
    
    self.label1.centerY = self.label2.centerY = self.label3.centerY = self.cellModel.cellHeight / 2;
}
@end
