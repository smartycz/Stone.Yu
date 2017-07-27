//
//  SYCellModel.h
//  Stone
//
//  Created by Stone.Yu on 2017/6/29.
//  Copyright © 2017年 Stone.Yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SYCellModel;

@protocol SYCellModelDelegate <NSObject>

@required

// 一般在 cellModel 的子类实现，也可以在viewController实现
- (CGFloat)cellHeightWithCellModel:(__kindof SYCellModel *)cellModel;

@end

@interface SYCellModel : NSObject

@property (nonatomic, copy) NSString *cellClassName;

@property (nonatomic, strong) id cellContent;
@property (nonatomic, assign) CGFloat cellHeight;

- (instancetype)initWithContent:(id)content andCellType:(NSString *)cellClassName;
- (instancetype)initWithContent:(id)content andCellType:(NSString *)cellClassName cellModelDelegate:(id<SYCellModelDelegate>)cellModelDelegate;

@end
