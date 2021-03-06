//
//  ViewController.m
//  Stone
//
//  Created by Stone.Yu on 2016/12/7.
//  Copyright © 2016年 Stone.Yu. All rights reserved.
//

#import "ViewController.h"
#import "SYTableViewController.h"

static const NSString *ViewControllerThreadTest = @"SYThreadTestViewController";
static const NSString *ViewControllerRuntimeTest = @"SYRuntimeTestViewController";
static const NSString *ViewControllerCellFactory = @"SYCellFactoryTestViewController";
static const NSString *ViewControllerViewControllerTransition = @"SYViewControllerTransitionViewController";
static const NSString *ViewControllerYYModel = @"SYyyModelTestViewController";
static const NSString *ViewControllerTableViewController = @"SYTableViewController";

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray <NSDictionary *>*dataArray;

@end

@implementation ViewController

- (void)initView
{
    UIImage *backButtonImage = [[UIImage imageNamed:@"backNewImage"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationController.navigationBar.backIndicatorImage = backButtonImage;
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage = backButtonImage;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:(UIBarButtonItemStylePlain) target:self action:nil];
    
    [self.navigationItem setTitle:@"主页"];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self.view addSubview:self.tableView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    self.navigationController.navigationBar.translucent = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self forbiddenAdjustsScrollViewInsets:self.tableView];
    
    [ViewController aspect_hookSelector:@selector(viewWillAppear:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo, BOOL animated){
        NSLog(@"aspectInfo = %@ \n aspectInfo.instance = %@ \n aspectInfo.originalInvocation = %@ \n", aspectInfo, aspectInfo.instance, aspectInfo.originalInvocation);
    } error:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSLog(@"viewWillAppear");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
}

- (BOOL)prefersStatusBarHidden
{
    return NO;
}

- (void)forbiddenAdjustsScrollViewInsets:(UIScrollView *)scrollview{
    _Pragma("clang diagnostic push")
    _Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"")
    if ([UIScrollView instancesRespondToSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:")]) {
        if (@available(iOS 11.0, *)) {
            [scrollview performSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:") withObject:@(UIScrollViewContentInsetAdjustmentNever)];
        } else {
            // Fallback on earlier versions
        }
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    _Pragma("clang diagnostic pop")
}

#pragma mark - Private Method
- (void)gotoViewController:(NSIndexPath *)indexPath
{
    NSDictionary *dic = self.dataArray[indexPath.row];
    NSString *classString = dic.allKeys[0];
    
    Class class = NSClassFromString(classString);
    if (class) {
        UIViewController *viewController = [[NSClassFromString(classString) alloc] init];
        [viewController.navigationItem setTitle:dic[classString]];
        if ([viewController isKindOfClass:[SYTableViewController class]]) {
            [self.navigationController presentViewController:viewController animated:YES completion:nil];
        } else {
            [self.navigationController pushViewController:viewController animated:YES];
        }
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
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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
    [self gotoViewController:indexPath];
}

#pragma mark - Getter And Setter

- (UITableView *)tableView
{
    if (nil == _tableView) {
        _tableView = ({
            UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame];
            [tableView setDataSource:self];
            [tableView setDelegate:self];
            tableView;
        });
    }
    
    return _tableView;
}

- (NSArray *)dataArray
{
    return @[
             @{ViewControllerThreadTest : @"多线程"},
             @{ViewControllerRuntimeTest : @"运行时"},
             @{ViewControllerCellFactory : @"cell工厂"},
             @{ViewControllerViewControllerTransition : @"转场"},
             @{ViewControllerYYModel : @"YYModel"},
             @{ViewControllerTableViewController : @"TableViewController"}];
}

@end
