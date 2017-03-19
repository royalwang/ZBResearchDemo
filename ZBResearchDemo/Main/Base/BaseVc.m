//
//  ViewController.m
//  ZBResearchDemo
//
//  Created by xzb on 2017/3/19.
//  Copyright © 2017年 xzb. All rights reserved.
//

#import "BaseVc.h"
static NSString *const VC_Cell_Identifier = @"xzb_001_cell";


@interface BaseVc ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *mainTabView;

@property (nonatomic, strong) NSArray <ControlModel *>*dataArray;

@end

@implementation BaseVc


#pragma mark - 生命周期

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"目录";
    
}
- (void)createUI
{
    [self.mainTabView registerClass:[UITableViewCell class] forCellReuseIdentifier:VC_Cell_Identifier];
    self.mainTabView.tableFooterView = [[UIView alloc] init];
    
}
- (void)customData
{
    self.dataArray = @[[ControlModel modelWithTitle:@"测试1" className:@"UIViewController"],
                       [ControlModel modelWithTitle:@"测试1" className:@"UIViewController"],
                       [ControlModel modelWithTitle:@"测试1" className:@"UIViewController"],
                       [ControlModel modelWithTitle:@"测试1" className:@"UIViewController"]];
    Log("%@",self.dataArray);
    
}
#pragma mark - api

#pragma mark - getter / setter

#pragma mark - model event

#pragma mark - view event

#pragma mark - private

#pragma mark - delegete
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:VC_Cell_Identifier];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    ControlModel *model = self.dataArray[indexPath.row];
    cell.textLabel.text = [model.title stringByAppendingFormat:@" -->Class:%@",model.controlName];
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
#pragma mark - notification

#pragma mark - kvo


@end



@implementation ControlModel


+ (instancetype)modelWithTitle:(NSString *)title className:(NSString *)className
{
    ControlModel *model =  [[self alloc] init];
    model.title = title;
    model.controlName = className;
    return model;
}
@end

