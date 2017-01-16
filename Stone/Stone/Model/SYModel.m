//
//  SYModel.m
//  Stone
//
//  Created by Stone.Yu on 2017/1/16.
//  Copyright © 2017年 Stone.Yu. All rights reserved.
//

#import "SYModel.h"
#import <objc/runtime.h>

NSString * const kBIFModelPropertyDefaultValue = @"";

@implementation SYModel

#pragma mark - publics

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

- (void)loadPropertiesWithData:(NSDictionary *)data
{
    if (![data isKindOfClass:[NSDictionary class]]) {
        DebugLog(@"load property error, data is not dictionary: %@", data);
        return;
    }
    
    for (NSString * key in [data keyEnumerator]) {
        if ([self respondsToSelector:NSSelectorFromString(key)]) {
            NSString *setter = [NSString stringWithFormat:@"set%@%@:",
                                [[key substringToIndex:1] uppercaseString],
                                [key substringFromIndex:1]];
            [self performSelector:NSSelectorFromString(setter)
                       withObject:data[key]];
        }
    }
}

- (NSArray *)loadArrayPropertyWithDataSource:(NSArray *)data requireModel:(NSString *)model
{
    if (![data isKindOfClass:[NSArray class]]) {
        DebugLog(@"load array property error, data is not array: %@", data);
        return nil;
    }
    
    NSMutableArray *p = [NSMutableArray array];
    for (NSDictionary *dic in data) {
        SYModel *m = [[NSClassFromString(model) alloc] init];
        if (![m isKindOfClass:[SYModel class]]) {
            DebugLog(@"load array property error, requireModel [%@] is not subclass of SYModel", model);
            return nil;
        }
        [m loadPropertiesWithData:dic];
        [p addObject:m];
    }
    
    return p;
}

#pragma clang diagnostic pop

#pragma mark - life cycle

- (instancetype)init
{
    if (self = [super init]) {
        [self resetAllValues];
    }
    
    return self;
}

#pragma mark - dictionaryRepresentation

/**
 *  全反射！
 */
- (NSMutableDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; ++ i) {
        NSString *propertyClassName = [self classNameFromType:CStringToNSSting(property_getAttributes(properties[i]))];
        NSString *propertyName = CStringToNSSting(property_getName(properties[i]));
        id propertyValue = [self valueForKey:propertyName];
        
        if (!propertyValue) {
            continue;
        }
        
        //是 SYModel 的子类
        if ([NSClassFromString(propertyClassName) isSubclassOfClass:[SYModel class]]) {
            dic[propertyName] = [propertyValue dictionaryRepresentation];
            continue;
        }
        
        //是数组
        if (NSClassFromString(propertyClassName) == [NSArray class]) {
            NSMutableArray *array = [NSMutableArray array];
            for (SYModel *model in propertyValue) {
                //目前只支持一层数组，若嵌套了两层数组，再贱→_→
                if ([model isKindOfClass:[SYModel class]]) {
                    [array addObject:[model dictionaryRepresentation]];
                } else {
                    [array addObject:model];
                }
            }
            dic[propertyName] = array;
            continue;
        }
        
        //其他情况
        dic[propertyName] = propertyValue;
    }
    
    return dic;
}

#pragma mark - reset values

- (void)resetAllValues
{
    [self resetAllValuesInClass:[self class]];
}

- (void)resetAllValuesInClass:(Class)class
{
    if ([class superclass] != [SYModel class]) {
        [self resetAllValuesInClass:[class superclass]];
    }
    
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList(class, &count);
    for (int i = 0; i < count; ++ i) {
        NSString *propertyClassName = [[NSString alloc] initWithCString:property_getAttributes(properties[i])
                                                               encoding:NSUTF8StringEncoding];
        propertyClassName = [self classNameFromType:propertyClassName];
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(properties[i])
                                                          encoding:NSUTF8StringEncoding];
        
        if (!propertyClassName) {
            continue;
        }
        
        //是 字符串 （一般属性）
        if ([propertyClassName isEqualToString:@"NSString"]) {
            [self setValue:kBIFModelPropertyDefaultValue
                    forKey:propertyName];
            continue;
        }
        
        //是嵌套类
        if ([NSClassFromString(propertyClassName) isSubclassOfClass:[SYModel class]]) {
            SYModel *model = [[NSClassFromString(propertyClassName) alloc] init];
            [self setValue:model
                    forKey:propertyName];
        }
    }
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

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {}
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    DebugLog(@"encode object [%@]%@", [self class], self);
}

@end
