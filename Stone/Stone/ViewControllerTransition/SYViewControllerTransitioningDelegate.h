//
//  SYViewControllerTransitioningDelegate.h
//  Stone
//
//  Created by Stone.Yu on 2017/7/22.
//  Copyright © 2017年 Stone.Yu. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SYTransitionAnimator.h"

@interface SYViewControllerTransitioningDelegate : NSObject <UIViewControllerTransitioningDelegate>

@property (nonatomic, weak) id<SYTransitionAnimatorDataSource> dataSource;
@property (nonatomic, strong) __kindof UIPresentationController *presentationController;

- (instancetype)initWithAnimationClassString:(NSString *)animationClass;
- (instancetype)initWithAnimationClassString:(NSString *)animationClass animatDuration:(NSTimeInterval)duration;

- (instancetype)initWithAnimationClassString:(NSString *)animationClass animatorDataSource:(id<SYTransitionAnimatorDataSource>)dataSource;
- (instancetype)initWithAnimationClassString:(NSString *)animationClass animatDuration:(NSTimeInterval)duration animatorDataSource:(id<SYTransitionAnimatorDataSource>)dataSource;

@end
