//
//  SYRuntimeTestViewController.m
//  Stone
//
//  Created by Stone.Yu on 2016/12/20.
//  Copyright © 2016年 Stone.Yu. All rights reserved.
//

#import "SYRuntimeTestViewController.h"
#import "SYMethodForwardTest.h"

static const NSString *SelectorNameMethodForwardTest = @"methodForwardTest";
static const NSString *SelectorNameMethodSwizzlingTest = @"methodSwizzlingTest";

@interface SYRuntimeTestViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray <NSDictionary *>*dataArray;

@end

@implementation SYRuntimeTestViewController

- (void)initView
{
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

- (void)methodForwardTest
{
    SYMethodForwardTest *methodForward = [[SYMethodForwardTest alloc] init];
    [methodForward test];
}

- (void)methodSwizzlingTest
{
    Class class = NSClassFromString(@"SYMethodSwizzlingTestViewController");
    
    if (class) {
        UIViewController *viewController = [[class alloc] init];
        [viewController.navigationItem setTitle:@"方法替换"];
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

#pragma mark - UITableViewDataSource And UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = nil;
    if (nil == cellIdentifier) {
        cellIdentifier = NSStringFromClass([UITableViewCell class]);
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell.textLabel setTextFont:[UIFont H18Font] textColor:[UIColor blueColor] text:self.dataArray[indexPath.row].allValues[0]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *selectorString = self.dataArray[indexPath.row].allKeys[0];
    SEL selector = NSSelectorFromString(selectorString);
    if ([self respondsToSelector:selector]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self performSelector:selector withObject:nil];
#pragma clang diagnostic pop
    }
    
    return;
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
             @{SelectorNameMethodForwardTest : @"消息转发"},
             @{SelectorNameMethodSwizzlingTest : @"方法替换"},
             ];
}

@end
