//
//  SYCellFactoryTestViewController.m
//  Stone
//
//  Created by Stone.Yu on 2017/6/29.
//  Copyright © 2017年 Stone.Yu. All rights reserved.
//

#import "SYCellFactoryTestViewController.h"

#import "SYCell1Model.h"
#import "SYTableViewCell.h"

@interface SYCellFactoryTestViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray <NSMutableArray *>*cellDataArray;

@end

@implementation SYCellFactoryTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    
    self.cellDataArray = [NSMutableArray array];
    
    SYCell1Model *cell1Model = [[SYCell1Model alloc] initWithContent:@[@"111", @"222", @"333"] andCellType:@"SYTableViewCell1"];
    
    SYCell1Model *cell2Model = [[SYCell1Model alloc] initWithContent:@[@"aaa", @"bbb", @"ccc"] andCellType:@"SYTableViewCell2"];
    
    [self.cellDataArray addObject:@[cell1Model,cell1Model].mutableCopy];
    [self.cellDataArray addObject:@[cell2Model,cell2Model].mutableCopy];
}

- (void)initView
{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource And UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.cellDataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cellDataArray[section].count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SYCell1Model *cellModel = self.cellDataArray[indexPath.section][indexPath.row];

    return cellModel.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SYCell1Model *cellModel = self.cellDataArray[indexPath.section][indexPath.row];
    
    SYTableViewCell * cell = [SYTableViewCell cellWithTableView:tableView cellType:cellModel.cellClassString delegata:self];
    
    [cell setCellWithData:cellModel];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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

@end
