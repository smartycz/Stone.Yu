//
//  UILabel+Style.h
//  Anjuke2
//
//  Created by Stone.Yu on 2016/12/6.
//  Copyright © 2016年 anjuke inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Style)

+ (UILabel *)labelWithTextFont:(UIFont *)font textColor:(UIColor *)color;
+ (UILabel *)labelWithTextFont:(UIFont *)font textColor:(UIColor *)color text:(NSString *)text;
+ (UILabel *)labelWithTextFont:(UIFont *)font textColor:(UIColor *)color backgroundColor:(UIColor *)backColor;
+ (UILabel *)labelWithTextFont:(UIFont *)font textColor:(UIColor *)color text:(NSString *)text backgroundColor:(UIColor *)backColor;
+ (UILabel *)labelWithTextFont:(UIFont *)font textColor:(UIColor *)color text:(NSString *)text alignment:(NSTextAlignment)alignment;
+ (UILabel *)labelWithTextFont:(UIFont *)font textColor:(UIColor *)color text:(NSString *)text backgroundColor:(UIColor *)backColor alignment:(NSTextAlignment)alignment;

- (void)setTextFont:(UIFont *)font textColor:(UIColor *)color;
- (void)setTextFont:(UIFont *)font textColor:(UIColor *)color text:(NSString *)text;
- (void)setTextFont:(UIFont *)font textColor:(UIColor *)color backgroundColor:(UIColor *)backColor;
- (void)setTextFont:(UIFont *)font textColor:(UIColor *)color text:(NSString *)text backgroundColor:(UIColor *)backColor;
- (void)setTextFont:(UIFont *)font textColor:(UIColor *)color text:(NSString *)text alignment:(NSTextAlignment)alignment;
- (void)setTextFont:(UIFont *)font textColor:(UIColor *)color text:(NSString *)text backgroundColor:(UIColor *)backColor alignment:(NSTextAlignment)alignment;

@end
