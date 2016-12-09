//
//  UIFont+Style.h
//  pregnancy
//
//  Created by Stone.Yu on 16/7/26.
//  Copyright © 2016年 babytree. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (Style)

/**
 *  常规字体
 */
+ (UIFont *)Font:(CGFloat)fontSize;
+ (UIFont *)H12Font;
+ (UIFont *)H13Font;
+ (UIFont *)H14Font;
+ (UIFont *)H15Font;
+ (UIFont *)H16Font;
+ (UIFont *)H17Font;
+ (UIFont *)H18Font;
+ (UIFont *)H19Font;
+ (UIFont *)H20Font;

/**
 *  粗体
 */
+ (UIFont *)BoldFont:(CGFloat)fontSize;
+ (UIFont *)H12BoldFont;
+ (UIFont *)H13BoldFont;
+ (UIFont *)H14BoldFont;
+ (UIFont *)H15BoldFont;
+ (UIFont *)H16BoldFont;
+ (UIFont *)H17BoldFont;
+ (UIFont *)H18BoldFont;
+ (UIFont *)H19BoldFont;
+ (UIFont *)H20BoldFont;

@end
