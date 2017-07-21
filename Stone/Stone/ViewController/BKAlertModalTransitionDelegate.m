//
//  BKAlertModalTransitionDelegate.m
//  AnjukeBroker_New
//
//  Created by James on 2017/6/5.
//  Copyright © 2017年 Anjuke. All rights reserved.
//

#import "BKAlertModalTransitionDelegate.h"
#import "BKAlertAnimationController.h"
#import "BKAlertPresentationController.h"

#define BKPresentedViewDefaultSize CGSizeMake(Screen_Width - 30, 300)

@implementation BKAlertModalTransitionDelegate

- (instancetype)init
{
    if (self = [super init]) {
        _presentedViewSize = BKPresentedViewDefaultSize;
    }
    return self;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    BKAlertAnimationController *alertAnimationController = [BKAlertAnimationController new];
    alertAnimationController.presentedViewSize = self.presentedViewSize;
    return alertAnimationController;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    BKAlertAnimationController *alertAnimationController = [BKAlertAnimationController new];
    alertAnimationController.presentedViewSize = self.presentedViewSize;
    return alertAnimationController;
}

- (nullable UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(nullable UIViewController *)presenting sourceViewController:(UIViewController *)source
{
    BKAlertPresentationController *alertPresentationController = [[BKAlertPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
    alertPresentationController.presentedViewSize = self.presentedViewSize;
    return alertPresentationController;
}

@end
