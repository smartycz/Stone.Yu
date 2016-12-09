//
//  UIButton+Style.h
//  Anjuke2
//
//  Created by Stone.Yu on 2016/12/6.
//  Copyright © 2016年 anjuke inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Style)

+ (UIButton *)buttonWithTitleFont:(UIFont *)font titleColor:(UIColor *)color;
+ (UIButton *)buttonWithTitleFont:(UIFont *)font titleColor:(UIColor *)color title:(NSString *)title;
+ (UIButton *)buttonWithTitleFont:(UIFont *)font titleColor:(UIColor *)color backgroundColor:(UIColor *)backColor;
+ (UIButton *)buttonWithTitleFont:(UIFont *)font titleColor:(UIColor *)color title:(NSString *)title backgroundColor:(UIColor *)backColor;

- (void)setTitleFont:(UIFont *)font titleColor:(UIColor *)color;
- (void)setTitleFont:(UIFont *)font titleColor:(UIColor *)color title:(NSString *)title;
- (void)setTitleFont:(UIFont *)font titleColor:(UIColor *)color backgroundColor:(UIColor *)backColor;
- (void)setTitleFont:(UIFont *)font titleColor:(UIColor *)color title:(NSString *)title backgroundColor:(UIColor *)backColor;

- (void)setTitleFont:(UIFont *)font titleColor:(UIColor *)color normalTitle:(NSString *)normalTitle selectedTitle:(NSString *)selectedTitle;

- (void)setNamalBackgroundImage:(UIImage *)nomalImage highLightBackgroundImage:(UIImage *)hlImage;

@end
