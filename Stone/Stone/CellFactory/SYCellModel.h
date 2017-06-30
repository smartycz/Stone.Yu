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

- (CGFloat)cellHeightWithCellModel:(__kindof SYCellModel *)cellModel;

@end

@interface SYCellModel : NSObject

@property (nonatomic, copy) NSString *cellClassString;

@property (nonatomic, strong) id cellContent;
@property (nonatomic, assign) CGFloat cellHeight;

@property (nonatomic, weak) id<SYCellModelDelegate> delegate;

- (instancetype)initWithContent:(id)content andCellType:(NSString *)cellClassString;

@end
