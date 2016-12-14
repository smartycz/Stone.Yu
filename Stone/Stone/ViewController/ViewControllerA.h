//
//  ViewControllerA.h
//  Stone
//
//  Created by Stone.Yu on 2016/12/12.
//  Copyright © 2016年 Stone.Yu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^changeColor)(UIColor *color);

@interface ViewControllerA : UIViewController

- (void)changeViewColor:(changeColor)color;

@end
