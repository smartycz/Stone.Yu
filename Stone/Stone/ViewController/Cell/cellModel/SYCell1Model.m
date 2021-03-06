//
//  SYCell1Model.m
//  Stone
//
//  Created by Stone.Yu on 2017/6/29.
//  Copyright © 2017年 Stone.Yu. All rights reserved.
//

#import "SYCell1Model.h"

@implementation SYCell1Model

- (CGFloat)cellHeightWithCellModel:(id)data
{
    CGFloat cellHeight = CGFLOAT_MIN;
    
    if ([data isKindOfClass:[NSArray class]]) {
        cellHeight = 50.0f;
    }
    
    return cellHeight;
}

@end
