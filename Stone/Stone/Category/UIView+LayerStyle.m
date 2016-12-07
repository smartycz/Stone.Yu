//
//  UIView+LayerStyle.m
//  Anjuke2
//
//  Created by Stone.Yu on 2016/12/7.
//  Copyright © 2016年 anjuke inc. All rights reserved.
//

#import "UIView+LayerStyle.h"

@implementation UIView (LayerStyle)

- (void)setLayerCordius:(CGFloat)cor
{
    [self setLayerCordius:cor borderWidth:CGFLOAT_MIN borderColor:nil layerBackColor:nil];
}

- (void)setLayerCordius:(CGFloat)cor borderWidth:(CGFloat)width
{
    [self setLayerCordius:cor borderWidth:width borderColor:nil layerBackColor:nil];
}

- (void)setLayerCordius:(CGFloat)cor borderWidth:(CGFloat)width borderColor:(UIColor *)color
{
    [self setLayerCordius:cor borderWidth:width borderColor:color layerBackColor:nil];
}

- (void)setLayerCordius:(CGFloat)cor borderWidth:(CGFloat)width borderColor:(UIColor *)color layerBackColor:(UIColor *)backColor
{
    [self.layer setMasksToBounds:YES];
    [self.layer setCornerRadius:cor];
    [self.layer setBorderWidth:width];
    
    if (color) {
        [self.layer setBorderColor:[color CGColor]];
    }
    
    if (backColor) {
        [self.layer setBackgroundColor:[backColor CGColor]];
    }
}

@end
