//
//  XXDownload.m
//  XXDownload
//
//  Created by tomxiang on 2017/2/22.
//  Copyright © 2017年 tomxiang. All rights reserved.
//

#import "XXDownload.h"
#import <UIKit/UIKit.h>

#define JSON_URL @"http://new.api.bandu.cn/book/listofgrade?id=2"
#define JSON_URL_FRONT @"http://new.api.bandu.cn/book/listofgrade"
#define URL_BIG_JPG @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1488214524647&di=9bd9c3979119e616f59e58640b14c3b9&imgtype=0&src=http%3A%2F%2Fd.hiphotos.baidu.com%2Fzhidao%2Fpic%2Fitem%2Fd0c8a786c9177f3ecc73d9b671cf3bc79e3d56c1.jpg" //https://pixabay.com/zh/
#define URL_SMALL_JPG @"http://pic55.nipic.com/file/20141208/19462408_171130083000_2.jpg"

@interface XXDownload()<NSURLConnectionDataDelegate,NSURLSessionDataDelegate>
@property(nonatomic,strong) NSMutableData *mulData;
@end

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

#pragma mark- Session Block Get
- (void)sync_sessionDataTaskGet{
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
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            NSLog(@"我回到了主线程!");
        }];
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
        NSThread *currentThead1 = [NSThread currentThread];
        NSOperationQueue *currentQueue1 = [NSOperationQueue currentQueue];
        
        NSLog(@"--CurrentThead1%@--",currentThead1);
        NSLog(@"--OperationQueue1--:%@",currentQueue1);
        
        [currentQueue1 addOperationWithBlock:^{
            NSThread *currentThead2 = [NSThread currentThread];
            NSOperationQueue *currentQueue2 = [NSOperationQueue currentQueue];
            
            NSLog(@"--CurrentThead2%@--",currentThead2);
            NSLog(@"--OperationQueue2--:%@",currentQueue2);
            
            if([currentThead1 isEqual:currentThead2]){
                NSLog(@"Thread Equal YES!");
            }
            
            if([currentQueue1 isEqual:currentQueue2]){
                NSLog(@"Queue Equal YES!");
            }
        }];
        
//        if(error == nil){
//            id objc = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//            NSLog(@"%@",objc);
//        }
        
//        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//            NSLog(@"我回到了主线程!");
//        }];
        

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

#pragma mark- Download block
- (void)async_sessionDownloadImg{
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:[NSURL URLWithString:URL_BIG_JPG] completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"currentThread--%@",[NSThread currentThread]);
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:location]];
            [self showImage:image];
        });
    }];
    
    [downloadTask resume];
}

-(void) showImage:(UIImage*) image{
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
    UIAlertView *Alert = [[UIAlertView alloc] initWithTitle:@"图片下载成功" message:nil
                                                   delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
#pragma clang diagnostic pop

    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 40, 40)];
    imageView.image = image;
    
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) {
        [Alert setValue:imageView forKey:@"accessoryView"];
    }else{
        [Alert addSubview:imageView];
    }
    
    [Alert show];
}

@end
