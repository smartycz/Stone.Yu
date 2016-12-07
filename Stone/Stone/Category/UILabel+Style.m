//
//  UILabel+Style.m
//  Anjuke2
//
//  Created by Stone.Yu on 2016/12/6.
//  Copyright © 2016年 anjuke inc. All rights reserved.
//

#import "UILabel+Style.h"

@implementation UILabel (Style)

+ (UILabel *)labelWithTextFont:(UIFont *)font textColor:(UIColor *)color
{
    return [UILabel labelWithTextFont:font textColor:color text:nil backgroundColor:nil alignment:NSTextAlignmentLeft];
}

+ (UILabel *)labelWithTextFont:(UIFont *)font textColor:(UIColor *)color text:(NSString *)text
{
    return [UILabel labelWithTextFont:font textColor:color text:text backgroundColor:nil alignment:NSTextAlignmentLeft];
}

+ (UILabel *)labelWithTextFont:(UIFont *)font textColor:(UIColor *)color backgroundColor:(UIColor *)backColor
{
    return [UILabel labelWithTextFont:font textColor:color text:nil backgroundColor:backColor alignment:NSTextAlignmentLeft];
}

+ (UILabel *)labelWithTextFont:(UIFont *)font textColor:(UIColor *)color text:(NSString *)text backgroundColor:(UIColor *)backColor
{
    return [UILabel labelWithTextFont:font textColor:color text:text backgroundColor:backColor alignment:NSTextAlignmentLeft];
}

+ (UILabel *)labelWithTextFont:(UIFont *)font textColor:(UIColor *)color text:(NSString *)text alignment:(NSTextAlignment)alignment
{
    return [UILabel labelWithTextFont:font textColor:color text:text backgroundColor:nil alignment:alignment];
}

+ (UILabel *)labelWithTextFont:(UIFont *)font textColor:(UIColor *)color text:(NSString *)text backgroundColor:(UIColor *)backColor alignment:(NSTextAlignment)alignment
{
    UILabel *label = [[UILabel alloc] init];
    
    [label setTextFont:font textColor:color text:text backgroundColor:backColor alignment:alignment];
    
    return label;
}


- (void)setTextFont:(UIFont *)font textColor:(UIColor *)color
{
    [self setTextFont:font textColor:color text:nil backgroundColor:nil alignment:NSTextAlignmentLeft];
}

- (void)setTextFont:(UIFont *)font textColor:(UIColor *)color text:(NSString *)text
{
    [self setTextFont:font textColor:color text:text backgroundColor:nil alignment:NSTextAlignmentLeft];
}

- (void)setTextFont:(UIFont *)font textColor:(UIColor *)color backgroundColor:(UIColor *)backColor
{
    [self setTextFont:font textColor:color text:nil backgroundColor:backColor alignment:NSTextAlignmentLeft];
}

- (void)setTextFont:(UIFont *)font textColor:(UIColor *)color text:(NSString *)text backgroundColor:(UIColor *)backColor
{
    [self setTextFont:font textColor:color text:text backgroundColor:backColor alignment:NSTextAlignmentLeft];
}

- (void)setTextFont:(UIFont *)font textColor:(UIColor *)color text:(NSString *)text alignment:(NSTextAlignment)alignment
{
    [self setTextFont:font textColor:color text:text backgroundColor:nil alignment:alignment];
}

- (void)setTextFont:(UIFont *)font textColor:(UIColor *)color text:(NSString *)text backgroundColor:(UIColor *)backColor alignment:(NSTextAlignment)alignment
{
    if (font) {
        [self setFont:font];
    }
    
    if (color) {
        [self setTextColor:color];
    }
    
    if (text) {
        [self setText:text];
    }
    
    if (backColor) {
        [self setBackgroundColor:backColor];
    }
    
    [self setTextAlignment:alignment];
}

@end
