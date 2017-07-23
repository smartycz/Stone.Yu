//
//  BKAlertAnimationController.m
//  AnjukeBroker_New
//
//  Created by James on 2017/6/5.
//  Copyright © 2017年 Anjuke. All rights reserved.
//

#import "BKAlertAnimationController.h"

@implementation BKAlertAnimationController

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.13;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIView *containerView = transitionContext.containerView;
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *fromView = fromViewController.view;
    UIView *toView = toViewController.view;
    
    if (toViewController.beingPresented) {
        
        [containerView addSubview:toView];
        
        CGFloat differenceWidth = containerView.width - self.presentedViewSize.width;
        CGFloat toViewWidth = self.presentedViewSize.width;
        CGFloat toViewHeight = self.presentedViewSize.height;
        
        toView.center = containerView.center;
        toView.bounds = CGRectMake(0, 0, toViewWidth, toViewHeight);
        
        UIGraphicsBeginImageContextWithOptions(toView.bounds.size, YES, 0);
        [toView drawViewHierarchyInRect:toView.bounds afterScreenUpdates:YES];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.center = containerView.center;
        imageView.bounds = CGRectMake(0, 0, toViewWidth + differenceWidth, toViewHeight + differenceWidth * toViewHeight / toViewWidth);
        imageView.layer.cornerRadius = 5;
        imageView.layer.masksToBounds = YES;
        [containerView addSubview:imageView];
        
        toView.layer.cornerRadius = 5;
        toView.layer.masksToBounds = YES;
        
        NSTimeInterval duration = [self transitionDuration:transitionContext];
        [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            imageView.bounds = CGRectMake(0, 0, toViewWidth, toViewHeight);
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
            [imageView removeFromSuperview];
        }];
        
    } else if (fromViewController.beingDismissed) {
        NSTimeInterval duration = [self transitionDuration:transitionContext];
        [UIView animateWithDuration:duration animations:^{
            fromView.alpha = 0;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        }];
        
    }
}

- (void)dealloc
{
    
}

@end
