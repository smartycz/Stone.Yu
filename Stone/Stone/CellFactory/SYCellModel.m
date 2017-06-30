//
//  SYCellModel.m
//  Stone
//
//  Created by Stone.Yu on 2017/6/29.
//  Copyright © 2017年 Stone.Yu. All rights reserved.
//

#import "SYCellModel.h"

@implementation SYCellModel

- (instancetype)initWithContent:(id)content andCellType:(NSString *)cellClassString
{
    if (self = [super init]) {
        self.cellContent = content;
        self.cellClassString = cellClassString;
        
        if ([self conformsToProtocol:@protocol(SYCellModelDelegate)]) {
            self.delegate = (id <SYCellModelDelegate>)self;
            self.cellHeight = [self.delegate cellHeightWithCellModel:self];
        }
    }
    
    return self;
}

@end
