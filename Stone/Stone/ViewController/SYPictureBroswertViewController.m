//
//  SYPictureBroswertViewController.m
//  Stone
//
//  Created by Stone.Yu on 2017/7/21.
//  Copyright © 2017年 Stone.Yu. All rights reserved.
//

#import "SYPictureBroswertViewController.h"

@interface SYPictureBroswertViewController ()

@end

@implementation SYPictureBroswertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
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

@end
