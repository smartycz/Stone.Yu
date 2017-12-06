//
//  SYPictureBroswertViewController.m
//  Stone
//
//  Created by Stone.Yu on 2017/7/21.
//  Copyright © 2017年 Stone.Yu. All rights reserved.
//

#import "SYPictureBroswertViewController.h"
#import "SYViewControllerTransitioningDelegate.h"

#define kTransitionAnimatorA @"SYPictureBroswerTransitionAnimator"

@interface SYPictureBroswertViewController () <SYTransitionAnimatorDataSource>

@property (nonatomic, strong) SYViewControllerTransitioningDelegate *transitionDelegate;

@end

@implementation SYPictureBroswertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.transitioningDelegate = self.transitionDelegate;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:({
        UIView *backView = [[UIView alloc] initWithFrame:self.view.bounds];
        backView.backgroundColor = [UIColor blackColor];
        backView;
    })];
    
    [self.view addSubview:({
        UITapGestureRecognizer *tag = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissView)];
        UIImage *image = [UIImage imageNamed:@"1"];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.width = Screen_Width;
        imageView.height = image.size.height * Screen_Width / image.size.width;
        imageView.center = self.view.center;
        imageView.userInteractionEnabled = YES;
        [imageView addGestureRecognizer:tag];
        imageView;
    })];
}

- (void)dismissView
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    
}

#pragma mark - SYTransitionAnimatorDataSource

- (CGRect)originRect
{
    return _originRect;
}

- (CGRect)targetRect
{
    UIImage *image = [UIImage imageNamed:@"1"];
    CGFloat height = image.size.height * Screen_Width / image.size.width;
    
    return CGRectMake(0, CGRectGetMidY(self.view.frame) - height / 2, Screen_Width, height);
}

- (id)content
{
    return [UIImage imageNamed:@"1"];
}

- (SYViewControllerTransitioningDelegate *)transitionDelegate
{
    if (!_transitionDelegate) {
        SYViewControllerTransitioningDelegate *transitionDelegate = [[SYViewControllerTransitioningDelegate alloc] initWithAnimationClassString:kTransitionAnimatorA animatDuration:0.5 animatorDataSource:self];
        _transitionDelegate = transitionDelegate;
    }
    
    return _transitionDelegate;
}


@end
