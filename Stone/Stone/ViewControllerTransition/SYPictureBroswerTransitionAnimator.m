//
//  SYPictureBroswerTransitionAnimator.m
//  Stone
//
//  Created by Stone.Yu on 2017/7/22.
//  Copyright © 2017年 Stone.Yu. All rights reserved.
//

#import "SYPictureBroswerTransitionAnimator.h"

@interface SYPictureBroswerTransitionAnimator ()

@end

@implementation SYPictureBroswerTransitionAnimator

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIView *containerView = transitionContext.containerView;

    UIViewController *fromViewController;
    UIView *fromView;
    
    UIViewController *toViewController;
    UIView *toView;
    
    fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    fromView = fromViewController.view;
    
    toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    toView = toViewController.view;
    
    CGRect startRect;
    CGRect endRect;

    if (toViewController.beingPresented) {
        startRect = self.animatorDataSource.originRect;
        endRect = self.animatorDataSource.targetRect;
        toView.alpha = 0;
    } else {
        startRect = self.animatorDataSource.targetRect;
        endRect = self.animatorDataSource.originRect;
    }
    
    UIView *backView = [self backViewWithRect:containerView.bounds];
    backView.alpha = !toViewController.beingPresented;
    UIImageView *imageView = [self imageViewWithRect:startRect];
    
    [containerView addSubview:toView];
    [containerView addSubview:backView];
    [containerView addSubview:imageView];

    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        imageView.frame = endRect;
        backView.alpha = toViewController.beingPresented;
    } completion:^(BOOL finished) {
        if (finished) {
            toView.alpha = 1;
            
            [backView removeFromSuperview];
            [imageView removeFromSuperview];

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

- (void)hiddenSubviewsFromView:(UIView *)view isHidden:(BOOL)hidden
{
    for (UIView *subview in view.subviews) {
        subview.hidden = hidden;
    }
}

- (UIImageView *)imageViewWithRect:(CGRect)rect
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:self.animatorDataSource.content];
    imageView.frame = rect;
    return imageView;
}

- (UIView *)backViewWithRect:(CGRect)rect
{
    UIView *backView = [[UIView alloc] initWithFrame:rect];
    backView.backgroundColor = [UIColor whiteColor];
    return backView;
}

- (void)dealloc {
    
}

@end
