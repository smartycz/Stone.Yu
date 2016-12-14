//
//  ViewControllerA.m
//  Stone
//
//  Created by Stone.Yu on 2016/12/12.
//  Copyright © 2016年 Stone.Yu. All rights reserved.
//

#import "ViewControllerA.h"

@interface ViewControllerA ()

@property (nonatomic, strong) changeColor changeColor;

@end

@implementation ViewControllerA

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *button = [UIButton buttonWithTitleFont:[UIFont H18Font] titleColor:[UIColor grayColor] title:@"avc" backgroundColor:[UIColor lightGrayColor]];
    button.frame = CGRectMake(15, 64, 150, 50);
    [self.view addSubview:button];
    [button addTarget:self action:@selector(changeViewColor) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)changeViewColor
{
    if (self.changeColor) {
        changeColor;
    }
}

//- (void)changeViewColor:(changeColor)color
//{
//    
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
