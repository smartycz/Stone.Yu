//
//  ViewController.m
//  Stone
//
//  Created by Stone.Yu on 2016/12/7.
//  Copyright © 2016年 Stone.Yu. All rights reserved.
//

#import "ViewController.h"

static const NSString *ViewControllerThreadTest = @"SYThreadTestViewController";

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray <NSDictionary *>*dataArray;

@end

@implementation ViewController

- (void)initView
{
    [self.navigationItem setTitle:@"主页"];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self.view addSubview:self.tableView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
}

#pragma mark - Private Method
- (void)gotoViewController:(NSIndexPath *)indexPath
{
    NSDictionary *dic = self.dataArray[indexPath.row];
    NSString *classString = dic.allKeys[0];
    
    UIViewController *viewController = [[NSClassFromString(classString) alloc] init];
    [viewController.navigationItem setTitle:dic[classString]];
    
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - UITableViewDataSource And UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([UITableViewCell class])];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    [cell.textLabel setTextFont:[UIFont H18Font] textColor:[UIColor blueColor] text:self.dataArray[indexPath.row].allValues[0]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self gotoViewController:indexPath];
}

#pragma mark - Getter And Setter

- (UITableView *)tableView
{
    if (nil == _tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame];
        [_tableView setDataSource:self];
        [_tableView setDelegate:self];
    }
    
    return _tableView;
}

- (NSArray *)dataArray
{
    return @[
             @{ViewControllerThreadTest : @"多线程"}
             ];
}

@end
