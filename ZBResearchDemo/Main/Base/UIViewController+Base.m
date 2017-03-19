//
//  UIViewController+Base.m
//  ZBResearchDemo
//
//  Created by xzb on 2017/3/19.
//  Copyright © 2017年 xzb. All rights reserved.
//

#import "UIViewController+Base.h"
#import "Aspects.h"

@implementation UIViewController (Base)

+ (void)load
{
    NSError *error = nil;
    [self aspect_hookSelector:@selector(viewDidLoad) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo){
        
        UIViewController *baseVc = [aspectInfo instance];
        [baseVc createUI];
        [baseVc customData];
        [baseVc askNetwork];
        
    }error:&error];
    if (error)
    {
        Log(@"Load error: %@",error);
    }
}
- (void)createUI
{
}
- (void)customData
{
}
- (void)askNetwork
{
}

@end
