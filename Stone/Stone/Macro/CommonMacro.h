//
//  CommonMacro.h
//  Stone
//
//  Created by Stone.Yu on 2016/12/9.
//  Copyright © 2016年 Stone.Yu. All rights reserved.
//

#ifndef CommonMacro_h
#define CommonMacro_h

// 获取屏幕 宽度、高度
#define Screen_Width                        ([UIScreen mainScreen].bounds.size.width)
#define Screen_Height                       ([UIScreen mainScreen].bounds.size.height)

// 定义 weakSelf
#define WEAK_SELF                           __weak __typeof(self)weakSelf = self;
#define STRONG_SELF                         __strong __typeof(weakSelf)self = weakSelf;

//Log
#ifdef DEBUG
#	define DebugLog(fmt, ...) NSLog((@"[%@]-%s #%d\n" fmt), [self class], __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#   define DebugSLog(fmt, ...) NSLog(fmt, __VA_ARGS__)
#else
#	define DebugLog(...)
#   define DebugSLog(...)
#endif

//CString
#define CStringToNSSting(A) [[NSString alloc] initWithCString:(A) encoding:NSUTF8StringEncoding]

#endif /* CommonMacro_h */
