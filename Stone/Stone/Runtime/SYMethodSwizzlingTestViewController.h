//
//  SYMethodSwizzlingTestViewController.h
//  Stone
//
//  Created by Stone.Yu on 2017/1/17.
//  Copyright © 2017年 Stone.Yu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

static inline void swizzleSelector(Class class, SEL originalSelector, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    if (class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@interface SYMethodSwizzlingTestViewController : UIViewController

@end
