//
//  SYViewControllerTransitionViewController.m
//  Stone
//
//  Created by Stone.Yu on 2017/7/21.
//  Copyright © 2017年 Stone.Yu. All rights reserved.
//

#import "SYViewControllerTransitionViewController.h"
#import "SYViewControllerTransitioningDelegate.h"
#import "SYPictureBroswertViewController.h"

@interface SYViewControllerTransitionViewController () <UIViewControllerTransitioningDelegate, SYTransitionAnimatorDataSource>

@property (nonatomic, strong) UIView *tapView;

@property (nonatomic, strong) SYViewControllerTransitioningDelegate *transitionDelegate;

@end

@implementation SYViewControllerTransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)dealloc
{
    
}

#pragma mark - UITableViewDataSource And UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([UITableViewCell class])];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UITapGestureRecognizer *tag1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tagImageView:)];
        UIImageView *imageView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1"]];
        imageView1.frame = CGRectMake(15, 10, 150, 130);
        imageView1.userInteractionEnabled = YES;
        [imageView1 addGestureRecognizer:tag1];
        [cell addSubview:imageView1];
        
        UITapGestureRecognizer *tag2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tagImageView:)];
        UIImageView *imageView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1"]];
        imageView2.frame = CGRectMake(imageView1.right + 20, 10, 150, 130);
        imageView2.userInteractionEnabled = YES;
        [imageView2 addGestureRecognizer:tag2];
        [cell addSubview:imageView2];
    }
    
    return cell;
}

#pragma mark - SYTransitionAnimatorDataSource

- (CGRect)originRect
{
    CGRect originRect = [[self.tapView superview] convertRect:self.tapView.frame toView:self.view];
    
    return CGRectMake(originRect.origin.x, originRect.origin.y + 64, originRect.size.width, originRect.size.height);
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

- (void)tagImageView:(UIGestureRecognizer *)tap
{
    self.tapView = tap.view;
    
    SYPictureBroswertViewController *vc = [SYPictureBroswertViewController new];
    vc.transitioningDelegate = self.transitionDelegate;
    [self.navigationController presentViewController:vc animated:YES completion:nil];
}

- (SYViewControllerTransitioningDelegate *)transitionDelegate
{
    if (!_transitionDelegate) {
        SYViewControllerTransitioningDelegate *transitionDelegate = [[SYViewControllerTransitioningDelegate alloc] initWithAnimationClassString:@"SYPictureBroswerTransitionAnimator" animatDuration:0.35 animatorDataSource:self];
        _transitionDelegate = transitionDelegate;
    }
    
    return _transitionDelegate;
}

@end
