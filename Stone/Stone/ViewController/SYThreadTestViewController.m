//
//  SYThreadTestViewController.m
//  Stone
//
//  Created by Stone.Yu on 2016/12/17.
//  Copyright © 2016年 Stone.Yu. All rights reserved.
//

#import "SYThreadTestViewController.h"
#import "SYThreadOperation.h"

@interface SYThreadTestViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation SYThreadTestViewController

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

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
}

#pragma mark - Private Method

//同步执行
- (void)performQueueUseSynchronization:(dispatch_queue_t)queue
{
    NSLog(@"\n当前线程：%@", [[SYThreadOperation sharedOperation] getCurrentThread]);

    for (int i = 0; i < 3; i++) {
        dispatch_sync(queue, ^{
            [[SYThreadOperation sharedOperation] currentThreadSleep:2];
            NSLog(@"\ni = %d 当前线程：%@", i, [[SYThreadOperation sharedOperation] getCurrentThread]);
        });
        NSLog(@"\ni = %d 执行完毕", i);
    }
    
    NSLog(@"\n所有队列使用同步方式执行完毕");
}

//同步执行串行队列
- (void)syncSeroalQueue
{
    dispatch_queue_t queue = [[SYThreadOperation sharedOperation] getSerialQueue:@"sync_Serial_Queue"];
    [self performQueueUseSynchronization:queue];
}

//同步执行并行队列
- (void)syncConcurrentQueue
{
    dispatch_queue_t queue = [[SYThreadOperation sharedOperation] getConcurrentQueue:@"sync_Concurrent_Queue"];
    [self performQueueUseSynchronization:queue];
}

//同步执行主队列
- (void)syncMainQueue
{
    dispatch_queue_t queue = [[SYThreadOperation sharedOperation] getMainQueue];
    [self performQueueUseSynchronization:queue];
}

//异步执行
- (void)performQueueUseAsynchronization:(dispatch_queue_t)queue
{
    NSLog(@"\n当前线程：%@", [[SYThreadOperation sharedOperation] getCurrentThread]);
    
    for (int i = 0; i < 3; i++) {
        dispatch_async(queue, ^{
            [[SYThreadOperation sharedOperation] currentThreadSleep:2];
            NSLog(@"\ni = %d 当前线程：%@", i, [[SYThreadOperation sharedOperation] getCurrentThread]);
        });
        NSLog(@"\ni = %d 执行完毕", i);
    }
    
    NSLog(@"\n所有队列使用同步方式执行完毕");
}

//异步执行串行队列
- (void)asyncSeroalQueue
{
    dispatch_queue_t queue = [[SYThreadOperation sharedOperation] getSerialQueue:@"async_Serial_Queue"];
    [self performQueueUseAsynchronization:queue];
}

//异步执行并行队列
- (void)asyncConcurrentQueue
{
    dispatch_queue_t queue = [[SYThreadOperation sharedOperation] getConcurrentQueue:@"async_Concurrent_Queue"];
    [self performQueueUseAsynchronization:queue];
}

//队列与组 自动关联并执行
- (void)performGroupQueue
{
    NSLog(@"\n当前线程：%@", [[SYThreadOperation sharedOperation] getCurrentThread]);

    dispatch_group_t group = dispatch_group_create();
    
    for (int i = 0; i < 3; i++) {
        dispatch_group_async(group, [[SYThreadOperation sharedOperation] getConcurrentQueue:@"group_async_Concurrent_Queue"], ^{
            [[SYThreadOperation sharedOperation] currentThreadSleep:1];
            NSLog(@"\n当前线程：%@", [[SYThreadOperation sharedOperation] getCurrentThread]);
            NSLog(@"\ni = %d 执行完毕",i );
        });
    }
    
    dispatch_group_notify(group, [[SYThreadOperation sharedOperation] getMainQueue], ^{
        NSLog(@"\n所有任务执行完毕");
    });
    
    NSLog(@"\n异步执行测试，不会阻塞主线程");
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
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    [cell.textLabel setTextFont:[UIFont H18Font] textColor:[UIColor blueColor] text:self.dataArray[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
            [self syncSeroalQueue];
            break;
            
        case 1:
            [self syncConcurrentQueue];
            break;
            
        case 2:
            [self syncConcurrentQueue];
            break;
            
        case 3:
            [self asyncSeroalQueue];
            break;
            
        case 4:
            [self asyncConcurrentQueue];
            break;
            
        case 5:
            [self performGroupQueue];
            break;
            
        default:
            break;
    }
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
             @"同步执行串行队列",
             @"同步执行并行队列",
             @"同步执行主队列",
             @"异步执行串行队列",
             @"异步执行并行队列",
             @"异步执行队列组"
             ];
}

@end
