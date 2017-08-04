//
//  UIImage+Editer.m
//  Stone
//
//  Created by Stone.Yu on 2017/8/4.
//  Copyright © 2017年 Stone.Yu. All rights reserved.
//

#import "UIImage+Editer.h"

@implementation UIImage (Editer)

+ (UIImage *)imageWithColor:(UIColor *)color
{
    return [self imageWithColor:color imageSize:CGSizeMake(1.0f, 1.0f)];
}

+ (UIImage *)imageWithColor:(UIColor *)color imageSize:(CGSize)size
{
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}

- (UIImage *)imageWithCornerRadius:(CGFloat)radius
{
    CGRect frame = CGRectMake(0, 0, self.size.width, self.size.height);
    // 开始一个Image的上下文
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    // 添加圆角
    [[UIBezierPath bezierPathWithRoundedRect:frame
                                cornerRadius:radius] addClip];
    // 绘制图片
    [self drawInRect:frame];
    // 接受绘制成功的图片
    UIImage *targetImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return targetImage;
}

@end
