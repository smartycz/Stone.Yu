//
//  SYyyModelTestViewController.m
//  Stone
//
//  Created by Stone.Yu on 2017/8/7.
//  Copyright © 2017年 Stone.Yu. All rights reserved.
//

#import "SYyyModelTestViewController.h"

#import <YYClassInfo.h>

@interface School : NSObject

@property (nonatomic, copy) NSString *name;

- (void)displaySchool;

@end

@implementation School

- (void)displaySchool
{
    NSLog(@"This is a school");
}

@end

@interface Student : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger age;
@property (nonatomic, strong) School *school;

- (void)displayStudent;

@end

@implementation Student

- (void)displayStudent
{
    NSLog(@"This is a student");
}

@end

@interface SYyyModelTestViewController ()

@end

@implementation SYyyModelTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    Student *student = [[Student alloc] init];
    YYClassInfo *yyClassInfo = [YYClassInfo classInfoWithClass:[student class]];
    
    NSLog(@"%@", yyClassInfo);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
