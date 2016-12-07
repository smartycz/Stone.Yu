//
//  UIView+LayerStyle.h
//  Anjuke2
//
//  Created by Stone.Yu on 2016/12/7.
//  Copyright © 2016年 anjuke inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LayerStyle)

- (void)setLayerCordius:(CGFloat)cor;

- (void)setLayerCordius:(CGFloat)cor borderWidth:(CGFloat)width;

- (void)setLayerCordius:(CGFloat)cor borderWidth:(CGFloat)width borderColor:(UIColor *)color;

- (void)setLayerCordius:(CGFloat)cor borderWidth:(CGFloat)width borderColor:(UIColor *)color layerBackColor:(UIColor *)backColor;

@end
