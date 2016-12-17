//
//  SYThreadOperation.h
//  Stone
//
//  Created by Stone.Yu on 2016/12/17.
//  Copyright © 2016年 Stone.Yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYThreadOperation : NSObject

+ (id)sharedOperation;

/**
 获取当前线程
 
 @return NSThread
 */
- (NSThread *)getCurrentThread;

/**
 获取当前线程
 
 @param timer 休眠时间/单位：s
 */
- (void)currentThreadSleep:(NSTimeInterval)timer;

/**
 获取主队列
 
 @return dispatch_queue_t
 */
- (dispatch_queue_t)getMainQueue;

/**
 获取全局队列
 
 @param priority 优先级
 
 DISPATCH_QUEUE_PRIORITY_HIGH                   高
 DISPATCH_QUEUE_PRIORITY_DEFAULT 0              默认
 DISPATCH_QUEUE_PRIORITY_LOW (-2)               低
 DISPATCH_QUEUE_PRIORITY_BACKGROUND INT16_MIN   后台
 
 @retuen dispatch_queue_t
 
 */
- (dispatch_queue_t)getGlobalQueue:(dispatch_queue_priority_t)priority;

/**
 创建并行队列
 
 @param label 并行队列标记
 
 @return dispatch_queue_t
 */
- (dispatch_queue_t)getConcurrentQueue:(NSString *)label;

/**
 创建串行队列
 
 @param label 串行队列标记
 
 @return dispatch_queue_t
 */
- (dispatch_queue_t)getSerialQueue:(NSString *)label;


@end
