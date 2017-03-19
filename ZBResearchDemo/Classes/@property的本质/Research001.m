//
//  Research001.m
//  ZBResearchDemo
//
//  Created by xzb on 2017/3/19.
//  Copyright © 2017年 xzb. All rights reserved.
//

#import "Research001.h"

@interface Research001 ()

@property (nonatomic, copy) NSString *name;

@end

@implementation Research001

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    objc_property_attribute_t type = { "T", "@\"NSString\"" };
    objc_property_attribute_t ownership = { "C", "" }; // C = copy
    objc_property_attribute_t nonatomic = { "N", "" };
    objc_property_attribute_t backingivar  = { "V", "_myName" };//V 实例变量
    objc_property_attribute_t attrs[] = { type, ownership,nonatomic, backingivar };
    class_addProperty([self class], "myName", attrs, 4);
    
//其中 “v@:” 表示返回值和参数

if(class_addMethod([self class],  NSSelectorFromString(@"myName"), (IMP)myNameGetter, "@@:"))
{
    NSLog(@"myName get 方法添加成功");
}
else
{
    NSLog(@"myName get 方法添加失败");
}

if(class_addMethod([self class], NSSelectorFromString(@"setMyName:"), (IMP)myNameSetter, "v@:@"))
{
    NSLog(@"myName set 方法添加成功");
}
else
{
    NSLog(@"myName set 方法添加失败");
}
    
    
    unsigned int count;
    objc_property_t *propertyList = class_copyPropertyList([self class], &count);
    for (unsigned int i = 0; i< count; i++)
    {
        const char *name = property_getName(propertyList[i]);
        NSLog(@"__%@",[NSString stringWithUTF8String:name]);
        objc_property_t property = propertyList[i];
        const char *a = property_getAttributes(property);
        NSLog(@"属性信息__%@",[NSString stringWithUTF8String:a]);
    }
    
    
    u_int methodCount;
    NSMutableArray *methodList = [NSMutableArray array];
    Method *methods = class_copyMethodList([self class], &methodCount);
    for (int i = 0; i < methodCount; i++)
    {
        SEL name = method_getName(methods[i]);
        NSString *strName = [NSString stringWithCString:sel_getName(name) encoding:NSUTF8StringEncoding];
        [methodList addObject:strName];
    }
    free(methods);
    
    NSLog(@"方法列表:%@",methodList);
    
}

NSString *myNameGetter(id self, SEL _cmd) {
    Ivar ivar = class_getInstanceVariable([self class], "myName");
    return object_getIvar(self, ivar);
}

void myNameSetter(id self, SEL _cmd, NSString *newName) {
    Ivar ivar = class_getInstanceVariable([self class], "myName");
    id oldName = object_getIvar(self, ivar);
    if (oldName != newName) object_setIvar(self, ivar, [newName copy]);
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    
}



@end
