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

- (instancetype)initWithContent:(id)content andCellType:(NSString *)cellClassName
{
    return [self initWithContent:content andCellType:cellClassName cellModelDelegate:nil];
}

- (instancetype)initWithContent:(id)content andCellType:(NSString *)cellClassName cellModelDelegate:(id<SYCellModelDelegate>)cellModelDelegate
{
    if (self = [super init]) {
        self.cellContent = content;
        self.cellClassName = cellClassName;
        
        if (cellModelDelegate) {
            self.cellModelDelegate = cellModelDelegate;
            self.cellHeight = [self.cellModelDelegate cellHeightWithCellModel:self];
        } else if ([self conformsToProtocol:@protocol(SYCellModelDelegate)]) {
            self.cellModelDelegate = (id <SYCellModelDelegate>)self;
            self.cellHeight = [self.cellModelDelegate cellHeightWithCellModel:self];
        } else {
            self.cellHeight  = CGFLOAT_MIN;
        }
    }
    
    return self;
}

@end
