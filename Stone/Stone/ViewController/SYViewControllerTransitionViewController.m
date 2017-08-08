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

@interface SYViewControllerTransitionViewController ()

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

- (void)tagImageView:(UIGestureRecognizer *)tap
{
    SYPictureBroswertViewController *vc = [SYPictureBroswertViewController new];
    CGRect originRect = [[tap.view superview] convertRect:tap.view.frame toView:self.view];
    vc.originRect = CGRectMake(originRect.origin.x, originRect.origin.y + 64, originRect.size.width, originRect.size.height);
    [self.navigationController presentViewController:vc animated:YES completion:nil];
}

@end
