//
//  SYTableViewHeaderFooterView.m
//  Stone
//
//  Created by Stone.Yu on 2017/8/8.
//  Copyright © 2017年 Stone.Yu. All rights reserved.
//

#import "SYTableViewHeaderFooterView.h"

@implementation SYTableViewHeaderFooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self initView];
        [self addSubViews];
    }
    
    return self;
}

+ (instancetype)headerFooterViewWithTableView:(UITableView *)tableView
{
    NSString *reuseIdentifier = NSStringFromClass([self class]);
    SYTableViewHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:reuseIdentifier];
    if (!view) {
        view = [[self alloc] initWithReuseIdentifier:reuseIdentifier];
    }
    
    return view;
}

+ (instancetype)headerFooterViewWithTableView:(UITableView *)tableView viewType:(NSString *)className
{
    return [self headerFooterViewWithTableView:tableView viewType:className delegata:nil];
}

+ (instancetype)headerFooterViewWithTableView:(UITableView *)tableView viewType:(NSString *)className delegata:(id<SYTableViewHeaderFooterViewDelegate>)delegate
{
    SYTableViewHeaderFooterView *view = nil;
    
    if (!className || !className.length) {
        return [SYTableViewHeaderFooterView headerFooterViewWithTableView:tableView];
    }
    
    Class class = NSClassFromString(className);
    
    if (class && [class isSubclassOfClass:[SYTableViewHeaderFooterView class]]) {
        view = [class headerFooterViewWithTableView:tableView];
        view.delegate = delegate;
    }
    
    if (!view) {
        view = [SYTableViewHeaderFooterView headerFooterViewWithTableView:tableView];
    }
    
    return view;
}

- (void)initView { }

- (void)addSubViews { }

- (void)setViewWithData:(__kindof SYCellModel *)viewModel
{
    self.viewModel = viewModel;
}

@end
