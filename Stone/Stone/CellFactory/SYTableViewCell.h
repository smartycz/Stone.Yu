//
//  SYTableViewCell.h
//  Stone
//
//  Created by Stone.Yu on 2017/6/29.
//  Copyright © 2017年 Stone.Yu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SYCellModel.h"

@class SYTableViewCell;

@protocol SYTableViewCellDelegate <NSObject>

@end

@interface SYTableViewCell : UITableViewCell

@property (nonatomic, weak) id<SYTableViewCellDelegate> delegate;

@property (nonatomic, strong) __kindof SYCellModel *cellModel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
+ (instancetype)cellWithTableView:(UITableView *)tableView cellType:(NSString *)cellClassName;
+ (instancetype)cellWithTableView:(UITableView *)tableView cellType:(NSString *)cellClassName
                         delegata:(id)delegate;

- (void)initCell;
- (void)addSubViews;

- (void)setCellWithData:(__kindof SYCellModel *)cellModel;

@end
