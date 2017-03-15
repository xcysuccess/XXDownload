//
//  XXURLNew.m
//  XXDownload
//
//  Created by tomxiang on 2017/3/15.
//  Copyright © 2017年 tomxiang. All rights reserved.
//

#import "XXURLNew.h"

#define JSON_URL @"http://new.api.bandu.cn/book/listofgrade?id=2"

#define JSON_URL_FRONT @"http://new.api.bandu.cn/book/listofgrade"

@interface XXURLNew ()<NSURLSessionDelegate,NSURLConnectionDataDelegate>
@property(nonatomic,strong) NSMutableData *mulData;
@end

@implementation XXURLNew

+ (instancetype)sharedInstance
{
    static XXURLNew *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[XXURLNew alloc] init];
    });
    return sharedInstance;
}

#pragma mark- Session Block Get
- (void)async_sessionDataTaskGet{
    NSURL *url = [NSURL URLWithString:JSON_URL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    /*
     *1.创建Session
     *2.根据创建任务
     *3.发送任务
     */
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"--%@--",[NSThread currentThread]);
        
        if(error == nil){
            id objc = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"%@",objc);
        }
    }];
    
    [dataTask resume];
}

#pragma mark- Session Block Post
- (void)async_sessionDataTaskPost{
    NSURL *url = [NSURL URLWithString:JSON_URL_FRONT];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    request.HTTPBody = [@"id=2" dataUsingEncoding:NSUTF8StringEncoding];
    /*
     *1.创建Session
     *2.根据创建任务
     *3.发送任务
     */
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"--%@--",[NSThread currentThread]);
        
        if(error == nil){
            id objc = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"%@",objc);
        }
    }];
    
    [dataTask resume];
}

#pragma mark- Session Data Delegate
- (void)async_sessionDataTaskPostDelegate{
    NSURL *url = [NSURL URLWithString:JSON_URL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    //    defaultSessionConfiguration:默认
    //    ephemeralSessionConfiguration;无痕
    //    backgroundSessionConfigurationWithIdentifier 后台
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionTask *dataTask = [session dataTaskWithRequest:request];
    
    [dataTask resume];
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
didReceiveResponse:(NSURLResponse *)response
 completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler{
    NSLog(@"Response=%@",response);
    if(_mulData){
        _mulData.length = 0;
    }else{
        _mulData = [NSMutableData data];
    }
    
    if(completionHandler){
        completionHandler(NSURLSessionResponseAllow);
    }
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data{
    [_mulData appendData:data];
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(nullable NSError *)error{
    if(error == nil){
        id objc = [NSJSONSerialization JSONObjectWithData:_mulData options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"--%@",objc);
    }
}

@end
