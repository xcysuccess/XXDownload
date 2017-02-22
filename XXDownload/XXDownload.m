//
//  XXDownload.m
//  XXDownload
//
//  Created by tomxiang on 2017/2/22.
//  Copyright © 2017年 tomxiang. All rights reserved.
//

#import "XXDownload.h"

#define JSON_URL @"http://new.api.bandu.cn/book/listofgrade"

@implementation XXDownload

+ (instancetype)sharedInstance
{
    static XXDownload *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[XXDownload alloc] init];
    });
    return sharedInstance;
}

- (void)sync_connection{
    /*
     *1.创建NSURL对象
     *2.创建NSURLRequest对象，默认是GET
     *3.使用NSURLConnection发送请求
     */
    NSURL *url = [NSURL URLWithString:JSON_URL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    /*
     *response:响应头,状态行
     *error:发送请求时出现的错误
     *data:响应内容
     */
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    if(!error){
        NSLog(@"---Header---:%@",response);

        NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"---Content---:%@",string);
    }else{
        NSLog(@"---Error---:%@",error);
    }
}


@end
