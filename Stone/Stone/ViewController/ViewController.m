//
//  ViewController.m
//  Stone
//
//  Created by Stone.Yu on 2016/12/7.
//  Copyright © 2016年 Stone.Yu. All rights reserved.
//

#import "ViewController.h"
#import "ViewControllerA.h"

@interface ViewController ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *reloadImageButton;
@property (nonatomic, strong) UIButton *refreshImageButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];

    [self.view addSubview:self.imageView];
    [self.view addSubview:self.reloadImageButton];
    [self.view addSubview:self.refreshImageButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [self.reloadImageButton centerXEqualToView:self.imageView];
    [self.reloadImageButton setTop:self.imageView.bottom + 10];
    
    [self.refreshImageButton centerXEqualToView:self.imageView];
    [self.refreshImageButton setTop:self.reloadImageButton.bottom + 10];
}

- (UIImageView *)imageView
{
    if (nil == _imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 70, 100, 100)];
        [_imageView setBackgroundColor:[UIColor grayColor]];
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:@"https://of4jd0bcc.qnssl.com/%E5%9B%BA%E5%AE%9A%E9%93%BE%E6%8E%A5%E6%9B%B4%E6%94%B9.jpg"]];
    }
    
    return _imageView;
}

- (void)reloadImage
{
    [[SDImageCache sharedImageCache] clearMemory];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:@"https://of4jd0bcc.qnssl.com/%E5%9B%BA%E5%AE%9A%E9%93%BE%E6%8E%A5%E6%9B%B4%E6%94%B9.jpg"]];
}

- (void)refreshImage
{
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:@"https://of4jd0bcc.qnssl.com/%E5%9B%BA%E5%AE%9A%E9%93%BE%E6%8E%A5%E6%9B%B4%E6%94%B9.jpg"]];
}

- (UIButton *)reloadImageButton
{
    if (nil == _reloadImageButton) {
        _reloadImageButton = [UIButton buttonWithTitleFont:[UIFont H18Font] titleColor:[UIColor lightTextColor] title:@"重新加载图片" backgroundColor:[UIColor grayColor]];
        [_reloadImageButton sizeToFit];
        [_reloadImageButton addTarget:self action:@selector(reloadImage) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _reloadImageButton;
}

- (UIButton *)refreshImageButton
{
    if (nil == _refreshImageButton) {
        _refreshImageButton = [UIButton buttonWithTitleFont:[UIFont H18Font] titleColor:[UIColor lightTextColor] title:@"刷新加载图片" backgroundColor:[UIColor grayColor]];
        [_refreshImageButton sizeToFit];
        [_refreshImageButton addTarget:self action:@selector(refreshImage) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _refreshImageButton;
}

@end
