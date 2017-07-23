//
//  SYTransitionAnimator.h
//  Stone
//
//  Created by Stone.Yu on 2017/7/22.
//  Copyright © 2017年 Stone.Yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SYTransitionAnimatorDataSource;

@interface SYTransitionAnimator : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, weak) id<SYTransitionAnimatorDataSource> animatorDataSource;

+ (instancetype)animationControllerWithAnimationClassString:(NSString *)classString;
+ (instancetype)animationControllerWithAnimationClassString:(NSString *)classString animateDuration:(NSTimeInterval)duration;
+ (instancetype)animationControllerWithAnimationClassString:(NSString *)classString animatorDataSource:(id<SYTransitionAnimatorDataSource>)dataSource;
+ (instancetype)animationControllerWithAnimationClassString:(NSString *)classString animateDuration:(NSTimeInterval)duration animatorDataSource:(id<SYTransitionAnimatorDataSource>)dataSource;

@end

@protocol SYTransitionAnimatorDataSource <NSObject>

@optional

- (CGRect)originRectTransitionAnimator:(SYTransitionAnimator *)animator;
- (CGRect)targetRectTransitionAnimator:(SYTransitionAnimator *)animator;

- (id)contentTransitionAnimator:(SYTransitionAnimator *)animator;

@end
