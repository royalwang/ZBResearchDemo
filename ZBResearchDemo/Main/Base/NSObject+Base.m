//
//  NSObject+Base.m
//  ZBResearchDemo
//
//  Created by xzb on 2017/3/19.
//  Copyright © 2017年 xzb. All rights reserved.
//

#import "NSObject+Base.h"
static NSMutableDictionary *modelsDescription = nil;
@implementation NSObject (Base)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        modelsDescription = [NSMutableDictionary dictionary];
    });
}
- (NSDictionary *)mapPropertiesToDictionary
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    Class cls = [self class];
    uint ivarsCount = 0;
    Ivar *ivars = class_copyIvarList(cls, &ivarsCount);
    const Ivar *ivarsEnd = ivars + ivarsCount;
    for (const Ivar *ivarsBegin = ivars; ivarsBegin < ivarsEnd; ivarsBegin++)
    {
        Ivar const ivar = *ivarsBegin;
        NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
        if ([key hasPrefix:@"_"])
            key = [key substringFromIndex:1];
        id value = [self valueForKey:key];
        [dictionary setObject:value ? value : [NSNull null] forKey:key];
    }
    if (ivars)
    {
        free(ivars);
    }
    return dictionary;
}

- (NSString *)description
{
    NSMutableString *str = [NSMutableString
                            stringWithFormat:@"------<%@>------\n", NSStringFromClass([self class])];
    NSDictionary *dic = [self mapPropertiesToDictionary];
    [dic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [str appendFormat:@"< %@ = %@ >\n", key, obj];
    }];
    [str appendString:@"------<End>------"];
    return str;
}
@end
