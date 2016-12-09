//
//  UIColor+Style.m
//  pregnancy
//
//  Created by Stone.Yu on 16/7/26.
//  Copyright © 2016年 babytree. All rights reserved.
//

#import "UIColor+Style.h"

@implementation UIColor (Style)

+ (UIColor*)randomColor
{
    int r = arc4random() % 255;
    int g = arc4random() % 255;
    int b = arc4random() % 255;
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1];
}

+ (UIColor *)colorWithHex:(uint)hex
{
    return [self colorWithHex:hex alpha:1.0f];
}

+ (UIColor *)colorWithHex:(uint)hex alpha:(CGFloat)alpha
{
    int red, green, blue;
    
    blue = hex & 0x0000FF;
    green = ((hex & 0x00FF00) >> 8);
    red = ((hex & 0xFF0000) >> 16);
    
    return [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:alpha];
}

+ (UIColor *)colorFromHexString:(NSString *)hexString
{
    return [self colorFromHexString:hexString alpha:1.0f];
}

+ (UIColor *)colorFromHexString:(NSString *)hexString alpha:(CGFloat)alpha
{
    unsigned rgbValue = 0;
    
    if (!hexString || hexString.length == 0) {
        hexString = @"#EB9239";
    }
    
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    
    return [UIColor colorWithHex:rgbValue alpha:alpha];
}

@end
