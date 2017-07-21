//
//  SYViewControllerTransitionViewController.m
//  Stone
//
//  Created by Stone.Yu on 2017/7/21.
//  Copyright © 2017年 Stone.Yu. All rights reserved.
//

#import "SYViewControllerTransitionViewController.h"

@interface SYViewControllerTransitionViewController ()

@property (nonatomic, strong) NSMutableArray *cellDataArray;

@end

@implementation SYViewControllerTransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cellDataArray = @[@"Presentation"].mutableCopy;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cellDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }
    cell.textLabel.text = self.cellDataArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIViewController *vc = [NSClassFromString(@"SYTestAllertViewController") new];
    [self.navigationController presentViewController:vc animated:YES completion:nil];
}

@end
