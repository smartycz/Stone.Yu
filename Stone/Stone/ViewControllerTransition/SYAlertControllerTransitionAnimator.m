//
//  SYAlertControllerTransitionAnimator.m
//  Stone
//
//  Created by Stone.Yu on 2017/8/8.
//  Copyright © 2017年 Stone.Yu. All rights reserved.
//

#import "SYAlertControllerTransitionAnimator.h"

@implementation SYAlertControllerTransitionAnimator

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIView *containerView = transitionContext.containerView;
    
    UIViewController *toViewController;
    UIView *toView;
    
    toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    toView = toViewController.view;
    
    toView.alpha = 0;
    [containerView addSubview:toView];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toView.alpha = 1;
    } completion:^(BOOL finished) {
        if (finished) {
            BOOL wasCancelled = [transitionContext transitionWasCancelled];
            [transitionContext completeTransition:!wasCancelled];
        }
    }];
}

- (id <UIViewImplicitlyAnimating>) interruptibleAnimatorForTransition:(id <UIViewControllerContextTransitioning>)transitionContext NS_AVAILABLE_IOS(10_0)
{
    return nil;
}

- (void)animationEnded:(BOOL)transitionCompleted
{
    
}

- (void)dealloc {
    
}

@end
