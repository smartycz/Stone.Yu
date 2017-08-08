//
//  SYCellModel.m
//  Stone
//
//  Created by Stone.Yu on 2017/6/29.
//  Copyright © 2017年 Stone.Yu. All rights reserved.
//

#import "SYCellModel.h"

@interface SYCellModel ()

@property (nonatomic, weak) id<SYCellModelDelegate> cellModelDelegate;

@end

@implementation SYCellModel

- (instancetype)initWithViewData:(id)data andCellType:(NSString *)className
{
    return [self initWithViewData:data andCellType:className cellModelDelegate:nil];
}

- (instancetype)initWithViewData:(id)data andCellType:(NSString *)className cellModelDelegate:(id<SYCellModelDelegate>)cellModelDelegate
{
    if (self = [super init]) {
        self.data = data;
        self.className = className;
        
        if (cellModelDelegate && [cellModelDelegate conformsToProtocol:@protocol(SYCellModelDelegate)]) {
            self.cellModelDelegate = cellModelDelegate;
        } else if ([self conformsToProtocol:@protocol(SYCellModelDelegate)]) {
            self.cellModelDelegate = (id <SYCellModelDelegate>)self;
        }
        
        self.cellHeight = [self getCellViewHeight];
        self.headerHeight = [self getHeaderViewHeight];
        self.footerHeight = [self getFooterViewHeight];
    }
    
    return self;
}

- (CGFloat)getCellViewHeight
{
    CGFloat height = CGFLOAT_MIN;
    
    if (self.cellModelDelegate && [self.cellModelDelegate respondsToSelector:@selector(cellHeightWithData:)]) {
        height = [self.cellModelDelegate cellHeightWithData:self.data];
    }
    
    return height;
}

- (CGFloat)getHeaderViewHeight
{
    CGFloat height = CGFLOAT_MIN;
    
    if (self.cellModelDelegate && [self.cellModelDelegate respondsToSelector:@selector(headerViewHeightWithData:)]) {
        height = [self.cellModelDelegate headerViewHeightWithData:self.data];
    }
    
    return height;
}

- (CGFloat)getFooterViewHeight
{
    CGFloat height = CGFLOAT_MIN;
    
    if (self.cellModelDelegate && [self.cellModelDelegate respondsToSelector:@selector(footerViewHeightWithData:)]) {
        height = [self.cellModelDelegate footerViewHeightWithData:self.data];
    }
    
    return height;
}

@end
