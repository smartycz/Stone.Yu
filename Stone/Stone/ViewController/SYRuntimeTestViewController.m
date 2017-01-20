//
//  SYRuntimeTestViewController.m
//  Stone
//
//  Created by Stone.Yu on 2016/12/20.
//  Copyright © 2016年 Stone.Yu. All rights reserved.
//

#import "SYRuntimeTestViewController.h"
#import "SYMethodForwardTest.h"
#import <objc/runtime.h>

static const NSString *SelectorNameMethodForwardTest = @"methodForwardTest";
static const NSString *SelectorNameMethodSwizzlingTest = @"methodSwizzlingTest";
static const NSString *SelectorNameClassMethodTest = @"classMethodTest";

@interface SYRuntimeTestViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray <NSDictionary *>*dataArray;

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger age;
@property (nonatomic, assign) BOOL bMan;

@end

@implementation SYRuntimeTestViewController

- (void)initView
{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.tableView];
}

- (void)initData
{
    self.name = @"Zhang Fei";
    self.age = 125;
    self.bMan = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    [self initData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Private Method

- (void)methodForwardTest
{
    SYMethodForwardTest *methodForward = [[SYMethodForwardTest alloc] init];
    [methodForward test];
}

- (void)methodSwizzlingTest
{
    Class class = NSClassFromString(@"SYMethodSwizzlingTestViewController");
    
    if (class) {
        UIViewController *viewController = [[class alloc] init];
        [viewController.navigationItem setTitle:@"方法替换"];
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

- (void)classMethodTest
{
    const char * className = class_getName([self class]);
    DebugLog(@"className = %s", className);
    
    Class superClass = class_getSuperclass([self class]);
    DebugLog(@"superClass = %@", superClass);
    
    size_t size = class_getInstanceSize([self class]);
    DebugLog(@"size = %zu", size);
    
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; ++ i) {
        NSString *propertyClassName = [self classNameFromType:CStringToNSSting(property_getAttributes(properties[i]))];
        DebugLog(@"propertyClassName = %@", propertyClassName);
        
        NSString *propertyName = CStringToNSSting(property_getName(properties[i]));
        DebugLog(@"propertyName = %@", propertyName);
        
        id propertyValue = [self valueForKey:propertyName];
        DebugLog(@"propertyValue = %@", propertyValue);
    }
    
    [self ex_registerClassPair];
}

void testMetaClass(id self, SEL _cmd) {
    NSLog(@"This objcet is %p", self);
    NSLog(@"Class is %@, super class is %@", [self class], [self superclass]);
    Class currentClass = [self class];
    for (int i = 0; i < 4; i++) {
        NSLog(@"Following the isa pointer %d times gives %p", i, currentClass);
        currentClass = objc_getClass((__bridge void *)currentClass);
    }
    NSLog(@"NSObject's class is %p", [NSObject class]);
    NSLog(@"NSObject's meta class is %p", objc_getClass((__bridge void *)[NSObject class]));
}

- (void)ex_registerClassPair {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    SEL selector = NSSelectorFromString(@"test");
    
    Class newClass = objc_allocateClassPair([NSError class], "TestClass", 0);//创建 TestClass 类，且为NSError子类
    class_addMethod(newClass, selector, (IMP)testMetaClass, "v@:");//添加 testMetaClass 方法
    objc_registerClassPair(newClass);
    
    id instance = [[newClass alloc] initWithDomain:@"some domain" code:0 userInfo:nil];
    [instance performSelector:selector];
#pragma clang diagnostic pop
}

- (NSString *)classNameFromType:(NSString *)propertyType
{
    NSArray *array = [propertyType componentsSeparatedByString:@"\""];
    if ([array count] == 3) {
        return array[1];
    } else {
        return nil;
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
        cell.accessoryType = UITableViewCellAccessoryNone;
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
             @{SelectorNameMethodForwardTest : @"消息转发"},
             @{SelectorNameMethodSwizzlingTest : @"方法替换"},
             @{SelectorNameClassMethodTest : @"类操作函数"},
             ];
}

@end
