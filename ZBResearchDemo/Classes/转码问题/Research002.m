//
//  Research002.m
//  ZBResearchDemo
//
//  Created by xzb on 2017/3/27.
//  Copyright © 2017年 xzb. All rights reserved.
//

#import "Research002.h"

@interface Research002 ()

@end

@implementation Research002

#pragma mark - UTF-8 /GBK
- (IBAction)GBKAndUTF8
{
    /**
     * GBK->UTF8
     */
    //方法一 旧方法
    NSString *encode1 = [@"%E6%88%91" stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    Log(@"--encode1->%@<------", encode1);
    
    //方法二   新方法
    Log(@"--encode2->%@<------", [@"%E6%88%91" stringByRemovingPercentEncoding]);
    
    /**
     *  UTF-8 ->GBK
     */
    //方法一 旧方法
    NSString *decode1 = [@"我" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    Log(@"--decode1-->%@<-----", decode1);
    
    //方法二 新方法
    Log(@"--decode1-->%@<-----",  [@"我" stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]);
}

#pragma mark - Unicode/UTF-8
- (IBAction)unicode:(id)sender {
    
//    replaceUnicode
}
/**
 *  Unicode码UTF-8
 *
 *  @param unicodeStr Unicode
 *
 *  @return UTF-8
 */
- (NSString *)replaceUnicode:(NSString *)unicodeStr
{
    NSString *tempStr1 = [unicodeStr stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    //旧方法
    //    NSString *returnStr = [NSPropertyListSerialization propertyListFromData:tempData mutabilityOption:NSPropertyListImmutable format:NULL errorDescription:NULL];
    //新方法
    NSString *returnStr = [NSPropertyListSerialization propertyListWithData:tempData options:NSPropertyListImmutable  format:NULL  error:NULL];
    
    
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"];
}
#pragma mark - GBK/UTF-8
- (IBAction)GBK_DeCode
{
    NSURL *url = [NSURL URLWithString:@"深圳银&#x884C"];
    
    NSData *responseData = [NSData dataWithContentsOfURL:url];
    
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:enc];
    
    Log(@"responseString :%@",responseString);
}
#pragma mark - UTF-8/GBK2312
//解码:从服务器请求数据,转成显示中文
- (NSString *)ChangeToChinessEncode:(NSString *)fileTitleStr
{
    if (fileTitleStr != NULL)
    {
        char *ReadStoreValue = (char *)[fileTitleStr cStringUsingEncoding:[NSString defaultCStringEncoding]];
        if ( ReadStoreValue != NULL )
        {
            fileTitleStr = [NSString stringWithCString:ReadStoreValue encoding: -2147482062];
        }
    }
    return fileTitleStr;
}


//编码:
- (NSString *)encodeString:(NSString *)string;
{
    NSString *urlEncoded = (__bridge_transfer NSString *) CFURLCreateStringByAddingPercentEscapes(
                                                                                                  NULL,
                                                                                                  (__bridge CFStringRef) string,
                                                                                                  NULL,
                                                                                                  (CFStringRef) @"!*'\"();:@&=+$,?%#[]% ",
                                                                                                  kCFStringEncodingGB_18030_2000);
    return urlEncoded;
}

@end
