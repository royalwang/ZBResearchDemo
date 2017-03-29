//
//  Research003.m
//  ZBResearchDemo
//
//  Created by xzb on 2017/3/29.
//  Copyright © 2017年 xzb. All rights reserved.
//

#import "Research003.h"

@interface Research003 ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *contenLabel;
@property (weak, nonatomic) IBOutlet UITextField *amountTextField;
@property (weak, nonatomic) IBOutlet UIView *backView;

@end

@implementation Research003
#pragma mark - 生命周期
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.amountTextField.keyboardType = UIKeyboardTypeDecimalPad;
    self.amountTextField.delegate = self;
    self.amountTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.amountTextField becomeFirstResponder];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}
#pragma mark - api

#pragma mark - getter / setter

#pragma mark - model event

#pragma mark - view event
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.amountTextField resignFirstResponder];
}
- (IBAction)amountTextFieldEditingChange:(UITextField *)sender
{
    sender.text = [self separatedDigitStringWithStr:sender.text];
    self.contenLabel.text = [NSString stringWithFormat:@"您输入的数字是:\n%@",sender.text];
}


#pragma mark - private
- (NSString *)separatedDigitStringWithStr:(NSString *)digitString
{
    if (digitString.length <= 3)
    {
        return digitString;
    }
    else
    {
        if ([digitString containsString:@"."])
        {
            return digitString;
        }
        
        NSMutableString *processString = [NSMutableString stringWithString:[digitString stringByReplacingOccurrencesOfString:@"," withString:@""]];
        NSInteger location = processString.length - 3;
        NSMutableArray *processArray = [NSMutableArray array];
        while (location >= 0) {
            NSString *temp = [processString substringWithRange:NSMakeRange(location, 3)];
            [processArray addObject:temp];
            if (location < 3 && location > 0)
            {
                NSString *t = [processString substringWithRange:NSMakeRange(0, location)];
                [processArray addObject:t];
            }
            location -= 3;
        }
        
        NSMutableArray *resultsArray = [NSMutableArray array];
        int k = 0;
        for (NSString *str in processArray)
        {
            k++;
            NSMutableString *tmp = [NSMutableString stringWithString:str];
            if (str.length > 2 && k < processArray.count )
            {
                [tmp insertString:@"," atIndex:0];
                [resultsArray addObject:tmp];
            }
            else
            {
                [resultsArray addObject:tmp];
            }
        }
        NSMutableString *resultString = [NSMutableString string];
        for (NSInteger i = resultsArray.count - 1 ; i >= 0; i--)
        {
            NSString *tmp = [resultsArray objectAtIndex:i];
            [resultString appendString:tmp];
        }
        return resultString;
    }
}
#pragma mark - delegete
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.amountTextField)
    {
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^(([1-9]\\d{0,9})|0)(\\.\\d{0,2})?$"];
        NSString *tmpStr = [[textField.text stringByAppendingString:string] stringByReplacingOccurrencesOfString:@"," withString:@""];
        BOOL isMatch = [pred evaluateWithObject:tmpStr];
        return isMatch;
    }
    return YES;
}
#pragma mark - notification

#pragma mark - kvo
@end
