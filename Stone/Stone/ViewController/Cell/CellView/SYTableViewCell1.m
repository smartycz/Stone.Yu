//
//  SYTableViewCell1.m
//  Stone
//
//  Created by Stone.Yu on 2017/6/29.
//  Copyright © 2017年 Stone.Yu. All rights reserved.
//

#import "SYTableViewCell1.h"

#import "SYCell1Model.h"

@interface SYTableViewCell1 ()

@property (nonatomic, strong) UILabel *label1;
@property (nonatomic, strong) UILabel *label2;
@property (nonatomic, strong) UILabel *label3;

@end

@implementation SYTableViewCell1

- (void)addSubViews
{
    [self.contentView addSubview:({
        UILabel *label1 = [UILabel labelWithTextFont:[UIFont H14Font] textColor:[UIColor colorWithHex:0xcccccc] backgroundColor:[UIColor grayColor]];
        [label1 setLayerCordius:2.0];
        self.label1 = label1;
    })];
    
    [self.contentView addSubview:({
        UILabel *label2 = [UILabel labelWithTextFont:[UIFont H14Font] textColor:[UIColor colorWithHex:0xbbbbbb] backgroundColor:[UIColor grayColor]];
        [label2 setLayerCordius:2.0];
        self.label2 = label2;
    })];
    
    [self.contentView addSubview:({
        UILabel *label3 = [UILabel labelWithTextFont:[UIFont H14Font] textColor:[UIColor colorWithHex:0xaaaaaa] backgroundColor:[UIColor grayColor]];
        [label3 setLayerCordius:2.0];
        self.label3 = label3;
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
    self.label1.left = 15;
    self.label2.left = self.label1.right + 10;
    self.label3.left = self.label2.right + 10;
    
    self.label1.centerY = self.label2.centerY = self.label3.centerY = self.cellModel.cellHeight / 2;
}

@end
