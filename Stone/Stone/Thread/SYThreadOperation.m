//
//  SYThreadOperation.m
//  Stone
//
//  Created by Stone.Yu on 2016/12/17.
//  Copyright © 2016年 Stone.Yu. All rights reserved.
//

#import "SYThreadOperation.h"

@implementation SYThreadOperation

+ (id)sharedOperation {
    static dispatch_once_t once;
    static SYThreadOperation *instance;
    dispatch_once(&once, ^{
        instance = [self new];
    });
    return instance;
}

- (NSThread *)getCurrentThread
{
    return [NSThread currentThread];
}

- (void)currentThreadSleep:(NSTimeInterval)timer
{
    [NSThread sleepForTimeInterval:timer];
}

- (dispatch_queue_t)getMainQueue
{
    return dispatch_get_main_queue();
}

- (dispatch_queue_t)getGlobalQueue:(dispatch_queue_priority_t)priority
{
    return dispatch_get_global_queue(priority, 0);
}

- (dispatch_queue_t)getConcurrentQueue:(NSString *)label
{
    label = (nil == label) ? @"" : label;
    return dispatch_queue_create([label cStringUsingEncoding:NSUTF8StringEncoding], DISPATCH_QUEUE_CONCURRENT);
}

- (dispatch_queue_t)getSerialQueue:(NSString *)label
{
    label = (nil == label) ? @"" : label;
    return dispatch_queue_create([label cStringUsingEncoding:NSUTF8StringEncoding], DISPATCH_QUEUE_SERIAL);
}

@end
