//
//  ViewController.h
//  ZBResearchDemo
//
//  Created by xzb on 2017/3/19.
//  Copyright © 2017年 xzb. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ControlModel;

@interface BaseVc : UIViewController


@end

@interface  ControlModel : NSObject

@property (nonatomic,copy) NSString *title;

@property (nonatomic, copy) NSString *controlName;

+ (instancetype)modelWithTitle:(NSString *)title className:(NSString *)className;

@end
