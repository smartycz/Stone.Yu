//
//  SYTransitionAnimator.m
//  Stone
//
//  Created by Stone.Yu on 2017/7/22.
//  Copyright © 2017年 Stone.Yu. All rights reserved.
//

#import "SYTransitionAnimator.h"

#define kAnimateDuration 0.35;

@interface SYTransitionAnimator ()

@property (nonatomic) NSTimeInterval duration;

@end

@implementation SYTransitionAnimator

+ (instancetype)animationControllerWithAnimationClassString:(NSString *)classString
{
    return [self animationControllerWithAnimationClassString:classString animateDuration:0 animatorDataSource:nil];
}

+ (instancetype)animationControllerWithAnimationClassString:(NSString *)classString animateDuration:(NSTimeInterval)duration
{
    return [self animationControllerWithAnimationClassString:classString animateDuration:duration animatorDataSource:nil];
}

+ (instancetype)animationControllerWithAnimationClassString:(NSString *)classString animatorDataSource:(id<SYTransitionAnimatorDataSource>)dataSource
{
    return [self animationControllerWithAnimationClassString:classString animateDuration:0 animatorDataSource:dataSource];
}

+ (instancetype)animationControllerWithAnimationClassString:(NSString *)classString animateDuration:(NSTimeInterval)duration animatorDataSource:(id<SYTransitionAnimatorDataSource>)dataSource
{
    SYTransitionAnimator *animationController = nil;
    
    if (!classString || !classString.length) {
        return nil;
    }
    
    Class class = NSClassFromString(classString);
    if (class && [class isSubclassOfClass:[SYTransitionAnimator class]]) {
        animationController = [[class alloc] init];
        animationController.duration = duration > 0 ? duration : kAnimateDuration;
        animationController.animatorDataSource = dataSource;
    }
    
    return animationController;
}

- (void)dealloc {
    
}

#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return self.duration;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext { }

- (id <UIViewImplicitlyAnimating>) interruptibleAnimatorForTransition:(id <UIViewControllerContextTransitioning>)transitionContext NS_AVAILABLE_IOS(10_0)
{
    return nil;
}

- (void)animationEnded:(BOOL)transitionCompleted { }

@end
