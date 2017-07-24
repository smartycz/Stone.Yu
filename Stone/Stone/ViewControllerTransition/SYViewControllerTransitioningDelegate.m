//
//  SYViewControllerTransitioningDelegate.m
//  Stone
//
//  Created by Stone.Yu on 2017/7/22.
//  Copyright © 2017年 Stone.Yu. All rights reserved.
//

#import "SYViewControllerTransitioningDelegate.h"

#define kAnimateDuration 0.35;

@interface SYViewControllerTransitioningDelegate ()

@property (nonatomic, copy) NSString *animationClass;
@property (nonatomic) NSTimeInterval duration;

@end

@implementation SYViewControllerTransitioningDelegate

- (instancetype)initWithAnimationClassString:(NSString *)animationClass
{
    return [self initWithAnimationClassString:animationClass animatDuration:0 animatorDataSource:nil];
}

- (instancetype)initWithAnimationClassString:(NSString *)animationClass animatDuration:(NSTimeInterval)duration
{
    return [self initWithAnimationClassString:animationClass animatDuration:duration animatorDataSource:nil];
}

- (instancetype)initWithAnimationClassString:(NSString *)animationClass animatorDataSource:(id<SYTransitionAnimatorDataSource>)dataSource
{
    return [self initWithAnimationClassString:animationClass animatDuration:0 animatorDataSource:dataSource];
}

- (instancetype)initWithAnimationClassString:(NSString *)animationClass animatDuration:(NSTimeInterval)duration animatorDataSource:(id<SYTransitionAnimatorDataSource>)dataSource
{
    if (self = [super init]) {
        _animationClass = animationClass;
        _duration = duration > 0 ? duration : kAnimateDuration;
        _dataSource = dataSource;
    }
    return self;
}

- (void)dealloc {
    
}

#pragma mark - UIViewControllerTransitioningDelegate

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    SYTransitionAnimator *animator = [SYTransitionAnimator animationControllerWithAnimationClassString:self.animationClass animateDuration:self.duration animatorDataSource:self.dataSource];
    return animator;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    SYTransitionAnimator *animator = [SYTransitionAnimator animationControllerWithAnimationClassString:self.animationClass animateDuration:self.duration animatorDataSource:self.dataSource];
    return animator;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator
{
    return nil;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator
{
    return nil;
}

- (nullable UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(nullable UIViewController *)presenting sourceViewController:(UIViewController *)source NS_AVAILABLE_IOS(8_0)
{
    return nil;
}

@end
