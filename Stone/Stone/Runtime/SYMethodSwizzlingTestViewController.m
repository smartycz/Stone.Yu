//
//  SYMethodSwizzlingTestViewController.m
//  Stone
//
//  Created by Stone.Yu on 2017/1/17.
//  Copyright © 2017年 Stone.Yu. All rights reserved.
//

#import "SYMethodSwizzlingTestViewController.h"

@interface SYMethodSwizzlingTestViewController ()

@end

@implementation SYMethodSwizzlingTestViewController

/**
 *  load方法在这个文件被程序装载时调用。只要是在Compile Sources中出现的文件总是会被装载，这与这个类是否被用到无关，因此load方法总是在main函数之前调用。
 *  如果一个类实现了load方法，在调用这个方法前会首先调用父类的load方法。而且这个过程是自动完成的，并不需要我们手动实现
 *  如果一个类没有实现load方法，那么就不会调用它父类的load方法，这一点与正常的类继承和方法调用不一样，需要额外注意一下。
 *  调用顺序：父类，子类(不需要显示调用父类方法，会自动调用)，扩展类（category）,都只会调用一次
 *  load和initialize方法内部使用了锁，因此它们是线程安全的。实现时要尽可能保持简单，避免阻塞线程，不要再使用锁
 */
+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        swizzleSelector([self class], @selector(methodA), @selector(methodB));
    });
}

/**
 *  这个方法在第一次给某个类发送消息时调用（比如实例化一个对象），并且只会调用一次。initialize方法实际上是一种惰性调用，也就是说如果一个类一直没被用到，那它的initialize方法也不会被调用，这一点有利于节约资源。
 *  与load方法类似的是，在initialize方法内部也会调用父类的方法，而且不需要我们显示的写出来。与load方法不同之处在于，即使子类没有实现initialize方法，也会调用父类的方法
 *  调用子类会自动调用父类，会导致父类initialize调用多次
 */
+ (void)initialize
{
    if (self == [SYMethodSwizzlingTestViewController class]) { // 避免是父类重复调用
        
    }
}

- (void)initView
{
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    
    [self methodA];
}

- (void)methodA
{
    DebugLog(@"AAAAAAAAAAA");
}

- (void)methodB
{
    DebugLog(@"BBBBBBBBBBB");

    [self methodB];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
