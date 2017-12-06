//
//  SYTableViewPresentationController.m
//  Stone
//
//  Created by Stone.Yu on 2017/12/5.
//  Copyright © 2017年 Stone.Yu. All rights reserved.
//

#import "SYTableViewPresentationController.h"

@interface SYTableViewPresentationController ()

@property (nonatomic, strong) UIControl *dimmingView;

@end


@implementation SYTableViewPresentationController

- (void)presentationTransitionWillBegin
{
    self.dimmingView.frame = self.containerView.bounds;
    [self.containerView addSubview:self.dimmingView];
    
    [self.presentedViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        self.dimmingView.alpha = 0.5;
    } completion:nil];
}

- (void)dismissalTransitionWillBegin
{
    [self.presentedViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        self.dimmingView.alpha = 0;
    } completion:nil];
}

- (void)containerViewWillLayoutSubviews
{
    self.dimmingView.frame = self.containerView.bounds;
}

- (UIControl *)dimmingView
{
    if (!_dimmingView) {
        _dimmingView = [[UIControl alloc] init];
        _dimmingView.backgroundColor = [UIColor blackColor];
        _dimmingView.alpha = 0;
        [_dimmingView addTarget:self action:@selector(dismissView:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _dimmingView;
}

- (void)dismissView:(UIGestureRecognizer *)gesture
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc
{
    
}

@end
