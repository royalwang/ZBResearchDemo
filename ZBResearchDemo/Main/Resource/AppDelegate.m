//
//  AppDelegate.m
//  ZBResearchDemo
//
//  Created by xzb on 2017/3/19.
//  Copyright © 2017年 xzb. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self setupRootControllerWithClassName:@"BaseVc"];
    return YES;
}
- (void)setupRootControllerWithClassName:(NSString *)className
{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[ NSClassFromString(className) alloc] init]];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
}

@end
