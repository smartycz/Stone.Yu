//
//  SYTableViewHeaderFooterView.h
//  Stone
//
//  Created by Stone.Yu on 2017/8/8.
//  Copyright © 2017年 Stone.Yu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SYCellModel.h"

@class SYTableViewHeaderFooterView;

@protocol SYTableViewHeaderFooterViewDelegate <NSObject>

@end

@interface SYTableViewHeaderFooterView : UITableViewHeaderFooterView

@property (nonatomic, weak) id<SYTableViewHeaderFooterViewDelegate> delegate;

@property (nonatomic, strong) __kindof SYCellModel *viewModel;

+ (instancetype)headerFooterViewWithTableView:(UITableView *)tableView;
+ (instancetype)headerFooterViewWithTableView:(UITableView *)tableView viewType:(NSString *)className;
+ (instancetype)headerFooterViewWithTableView:(UITableView *)tableView viewType:(NSString *)className delegata:(id<SYTableViewHeaderFooterViewDelegate>)delegate;

- (void)initView;
- (void)addSubViews;

- (void)setViewWithData:(__kindof SYCellModel *)viewModel;

@end
