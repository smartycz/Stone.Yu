//
//  SYCellModel.h
//  Stone
//
//  Created by Stone.Yu on 2017/6/29.
//  Copyright © 2017年 Stone.Yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SYCellModel;

// 一般在 cellModel 的子类实现，也可以在viewController实现
@protocol SYCellModelDelegate <NSObject>

- (CGFloat)cellHeightWithData:(id)data;

@optional

- (CGFloat)headerViewHeightWithData:(id)data;
- (CGFloat)footerViewHeightWithData:(id)data;

@end

@interface SYCellModel : NSObject

@property (nonatomic, copy) NSString *className;

@property (nonatomic, strong) id data;

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) CGFloat headerHeight;
@property (nonatomic, assign) CGFloat footerHeight;

- (instancetype)initWithViewData:(id)data andCellType:(NSString *)className;
- (instancetype)initWithViewData:(id)data andCellType:(NSString *)className cellModelDelegate:(id<SYCellModelDelegate>)cellModelDelegate;

@end
