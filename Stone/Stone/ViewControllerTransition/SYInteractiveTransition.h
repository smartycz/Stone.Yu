//
//  SYInteractiveTransition.h
//  Stone
//
//  Created by Stone.Yu on 2017/12/11.
//  Copyright © 2017年 Stone.Yu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SYInteractiveTransition : UIPercentDrivenInteractiveTransition

@property (nonatomic, assign) BOOL interacting;

- (void)wireToViewController:(UIViewController*)viewController;

@end
