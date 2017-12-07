//
//  SYRightMoveToLeftTransitionAnimator.m
//  Stone
//
//  Created by Stone.Yu on 2017/12/5.
//  Copyright © 2017年 Stone.Yu. All rights reserved.
//

#import "SYRightMoveToLeftTransitionAnimator.h"

#define kWidth Screen_Width / 2

@implementation SYRightMoveToLeftTransitionAnimator

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIView *containerView = transitionContext.containerView;
    
    UIViewController * fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *fromView = fromViewController.view;
    
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toView = toViewController.view;
    
    CGRect originRect = CGRectMake(containerView.width, 0, kWidth, containerView.height);
    CGRect targetRect = CGRectMake(containerView.width - kWidth, 0, kWidth, containerView.height);
    
    if (toViewController.isBeingPresented) {
        toView.frame = originRect;
        [containerView addSubview:toView];
    }
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        if (toViewController.beingPresented) {
            toView.frame = targetRect;
            
            fromView.left -= 50;
            CGAffineTransform transform = CGAffineTransformScale(fromView.transform, 0.95, 0.95);
            fromView.transform = transform;
        }
        else if (fromViewController.beingDismissed) {
            fromView.frame = originRect;
            
            toView.left += 50;
            toView.transform = fromView.transform;
        }
    } completion:^(BOOL finished) {
        if (finished) {
            BOOL wasCancelled = [transitionContext transitionWasCancelled];
            [transitionContext completeTransition:!wasCancelled];
        }
    }];
}

@end
