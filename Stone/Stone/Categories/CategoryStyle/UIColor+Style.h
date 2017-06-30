//
//  UIColor+Style.h
//  pregnancy
//
//  Created by Stone.Yu on 16/7/26.
//  Copyright © 2016年 babytree. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Style)

+ (UIColor *)randomColor;
+ (UIColor *)colorWithHex:(uint)hex;
+ (UIColor *)colorWithHex:(uint)hex alpha:(CGFloat)alpha;
+ (UIColor *)colorFromHexString:(NSString *)hexString;
+ (UIColor *)colorFromHexString:(NSString *)hexString alpha:(CGFloat)alpha;

@end
