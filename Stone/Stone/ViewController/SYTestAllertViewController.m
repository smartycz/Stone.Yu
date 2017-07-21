//
//  SYTestAllertViewController.m
//  Stone
//
//  Created by Stone.Yu on 2017/7/21.
//  Copyright © 2017年 Stone.Yu. All rights reserved.
//

#import "SYTestAllertViewController.h"

@interface SYTestAllertViewController ()

@end

@implementation SYTestAllertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:({
        UIControl *view = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
        view.center = self.view.center;
        view.backgroundColor = [UIColor lightGrayColor];
        [view addTarget:self action:@selector(dismissView) forControlEvents:UIControlEventTouchUpInside];
        view;
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

@end
