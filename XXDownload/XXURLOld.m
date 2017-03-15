//
//  XXURLOld.m
//  XXDownload
//
//  Created by tomxiang on 2017/3/15.
//  Copyright © 2017年 tomxiang. All rights reserved.
//

#import "XXURLOld.h"

#define JSON_URL @"http://new.api.bandu.cn/book/listofgrade?id=2"

@interface XXURLOld ()<NSURLConnectionDataDelegate>
@property(nonatomic,strong) NSMutableData *mulData;
@end

@implementation XXURLOld

+ (instancetype)sharedInstance
{
    static XXURLOld *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[XXURLOld alloc] init];
    });
    return sharedInstance;
}

#pragma mark- SyncConnection
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
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
#pragma clang diagnostic pop
    if(!error){
        NSLog(@"---Header---:%@",response);
        
        NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"---Content---:%@",string);
    }else{
        NSLog(@"---Error---:%@",error);
    }
}

#pragma mark- AsyncConnection Block
- (void)async_connectionWithCompletion:(void (^)())completion{
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
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
#pragma clang diagnostic pop
        if(connectionError == nil){
            NSLog(@"--Header--:%@",response);
            
            NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"---Content---:%@",string);
        }
        NSLog(@"currentThread=%@",[NSThread currentThread]);
        if (completion) {
            completion();
        }
    }];
}

#pragma mark- AsyncConnection Delegate
- (void)async_connectionWithDelegate{
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
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
    [NSURLConnection connectionWithRequest:request delegate:self];
#pragma clang diagnostic pop
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"Error=%@",error);
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSLog(@"Response=%@",response);
    _mulData = [NSMutableData data];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    NSLog(@"didReceiveData");
    [_mulData appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSLog(@"connectionDidFinishLoading");
    NSString *string = [[NSString alloc] initWithData:_mulData encoding:NSUTF8StringEncoding];
    NSLog(@"---Content---:%@",string);
}

@end
