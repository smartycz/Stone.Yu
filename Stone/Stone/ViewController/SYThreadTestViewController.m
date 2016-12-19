//
//  SYThreadTestViewController.m
//  Stone
//
//  Created by Stone.Yu on 2016/12/17.
//  Copyright © 2016年 Stone.Yu. All rights reserved.
//

#import "SYThreadTestViewController.h"
#import "SYThreadOperation.h"

static const NSString *SelectorNameSyncSeroalQueue = @"syncSeroalQueue";
static const NSString *SelectorNameSyncConcurrentQueue = @"syncConcurrentQueue";
static const NSString *SelectorNameSyncMainQueue = @"syncMainQueue";
static const NSString *SelectorNameAsyncSeroalQueue = @"asyncSeroalQueue";
static const NSString *SelectorNameAsyncConcurrentQueue = @"asyncConcurrentQueue";
static const NSString *SelectorNamePerformGroupQueue = @"performGroupQueue";
static const NSString *SelectorNamePerformGroupUseEnterAndLeave = @"performGroupUseEnterAndLeave";
static const NSString *SelectorNameSemaphoreLock = @"semaphoreLock";
static const NSString *SelectorUseDispatchApply = @"useDispatchApply";
static const NSString *SelectorQueueSuspend = @"queueSuspend";
static const NSString *SelectorUseBarrierAsync = @"useBarrierAsync";

@interface SYThreadTestViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray <NSDictionary *>*dataArray;

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

//队列与组 自动管理并执行
- (void)performGroupQueue
{
    NSLog(@"\n当前线程：%@", [[SYThreadOperation sharedOperation] getCurrentThread]);

    dispatch_group_t group = dispatch_group_create();
    
    for (int i = 0; i < 3; i++) {
        dispatch_group_async(group, [[SYThreadOperation sharedOperation] getConcurrentQueue:@"Group_Async_Concurrent_Queue"], ^{
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

//自动管理异步队列组
- (void)performGroupUseEnterAndLeave
{
    NSLog(@"\n当前线程：%@", [[SYThreadOperation sharedOperation] getCurrentThread]);
    
    dispatch_group_t group = dispatch_group_create();
    
    for (int i = 0; i < 3; i++) {
        dispatch_group_enter(group);
        
        dispatch_async([[SYThreadOperation sharedOperation] getConcurrentQueue:@"EnterAndLeave_Group_Async_Concurrent_Queue"], ^{
            [[SYThreadOperation sharedOperation] currentThreadSleep:1];
            NSLog(@"\n当前线程：%@", [[SYThreadOperation sharedOperation] getCurrentThread]);
            NSLog(@"\ni = %d 执行完毕",i );
            
            dispatch_group_leave(group);
        });
    }
    
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER); //阻塞当前线程，直到group执行完毕
    NSLog(@"\n所有任务执行完毕");
    
    dispatch_group_notify(group, [[SYThreadOperation sharedOperation] getMainQueue], ^{
        NSLog(@"\nEnterAndLeave任务执行完毕");
    });
    
    NSLog(@"\n当前线程：%@ %d", [[SYThreadOperation sharedOperation] getCurrentThread], __LINE__);
}

//信号量同步锁
- (void)semaphoreLock
{
    //创建信号量锁，信号量值为1
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    
    __block int testNumber = 0;
    
    for (int i = 0; i < 3; i++) {
        dispatch_async([[SYThreadOperation sharedOperation] getConcurrentQueue:@"Async_Concurrent_Queue"], ^{
            //信号量锁值减1   信号量值为0开始生效
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);  //上锁
            
            testNumber += 1;
            
            [[SYThreadOperation sharedOperation] currentThreadSleep:2];
            NSLog(@"\n当前线程：%@ %d", [[SYThreadOperation sharedOperation] getCurrentThread], __LINE__);
            NSLog(@"\ntestNumber = %d line = %d", testNumber, __LINE__);
            
            //信号量锁值加1
            dispatch_semaphore_signal(semaphore);   //开锁
        });
    }
    
    NSLog(@"\n当前线程：%@ %d", [[SYThreadOperation sharedOperation] getCurrentThread], __LINE__);
}

//队列循环执行，挂起，恢复
- (void)useDispatchApply
{
    NSLog(@"\n当前线程：%@ %d", [[SYThreadOperation sharedOperation] getCurrentThread], __LINE__);
    
    //会阻塞当前线程，虽然Apply_Concurrent_Queue队列会在新线程中执行
    dispatch_apply(2, [[SYThreadOperation sharedOperation] getConcurrentQueue:@"Apply_Concurrent_Queue"], ^(size_t index) {
       [[SYThreadOperation sharedOperation] currentThreadSleep:index];
        
        NSLog(@"\ni = %zu 执行完毕",index);
        NSLog(@"\n当前线程：%@ %d", [[SYThreadOperation sharedOperation] getCurrentThread], __LINE__);
    });
    
    //会阻塞当前线程，虽然Apply_Serial_Queue队列会在当前线程中执行
    dispatch_apply(2, [[SYThreadOperation sharedOperation] getSerialQueue:@"Apply_Serial_Queue"], ^(size_t index) {
        [[SYThreadOperation sharedOperation] currentThreadSleep:index];
        
        NSLog(@"\ni = %zu 执行完毕",index);
        NSLog(@"\n当前线程：%@ %d", [[SYThreadOperation sharedOperation] getCurrentThread], __LINE__);
    });
    
    NSLog(@"\n当前线程：%@ %d", [[SYThreadOperation sharedOperation] getCurrentThread], __LINE__);
}

//队列挂起与恢复
- (void)queueSuspend
{
    dispatch_queue_t queue = [[SYThreadOperation sharedOperation] getConcurrentQueue:@"Concurrent_Queue"];
    dispatch_suspend(queue); //队列挂起
    dispatch_async(queue, ^{
        NSLog(@"\n当前线程：%@ %d", [[SYThreadOperation sharedOperation] getCurrentThread], __LINE__);
    });
    
    [[SYThreadOperation sharedOperation] currentThreadSleep:2];
    
    dispatch_resume(queue);  //队列恢复
}

//任务栅栏
- (void)useBarrierAsync
{
    dispatch_queue_t queue = [[SYThreadOperation sharedOperation] getConcurrentQueue:@"Concurrent_Queue"];
    
    for (int i = 0; i < 3; i++) {
        dispatch_async(queue, ^{
            [[SYThreadOperation sharedOperation] currentThreadSleep:i];
            NSLog(@"\ni = %d 执行完毕",i);
            NSLog(@"\n当前线程：%@ %d", [[SYThreadOperation sharedOperation] getCurrentThread], __LINE__);
        });
    }
    
    dispatch_barrier_async(queue, ^{
        NSLog(@"\n第一批执行完了才会执行第二批");
        NSLog(@"\n当前线程：%@ %d", [[SYThreadOperation sharedOperation] getCurrentThread], __LINE__);
    });
    
    for (int i = 0; i < 3; i++) {
        dispatch_async(queue, ^{
            [[SYThreadOperation sharedOperation] currentThreadSleep:i];
            NSLog(@"\ni = %d 执行完毕",i);
            NSLog(@"\n当前线程：%@ %d", [[SYThreadOperation sharedOperation] getCurrentThread], __LINE__);
        });
    }
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
    
    [cell.textLabel setTextFont:[UIFont H18Font] textColor:[UIColor blueColor] text:self.dataArray[indexPath.row].allValues[0]];
    
    return cell;
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
             @{SelectorNameSyncSeroalQueue : @"同步执行串行队列"},
             @{SelectorNameSyncConcurrentQueue : @"同步执行并行队列"},
             @{SelectorNameSyncMainQueue : @"同步执行主队列"},
             @{SelectorNameAsyncSeroalQueue : @"异步执行串行队列"},
             @{SelectorNameAsyncConcurrentQueue : @"异步执行并行队列"},
             @{SelectorNamePerformGroupQueue : @"异步执行队列组"},
             @{SelectorNamePerformGroupUseEnterAndLeave : @"自动管理异步队列组"},
             @{SelectorNameSemaphoreLock : @"信号量锁测试"},
             @{SelectorUseDispatchApply : @"循环执行队列"},
             @{SelectorQueueSuspend : @"队列挂起与恢复"},
             @{SelectorUseBarrierAsync : @"任务栅栏"},
             ];
}

@end
