//
//  UIImage+Editer.h
//  Stone
//
//  Created by Stone.Yu on 2017/8/4.
//  Copyright © 2017年 Stone.Yu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Editer)

+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageWithColor:(UIColor *)color imageSize:(CGSize)size;

/// 切图片圆角
- (UIImage *)imageWithCornerRadius:(CGFloat)radius;

@end
