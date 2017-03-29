//
//  XXNetMonitorAFNetworking.m
//  XXDownload
//
//  Created by tomxiang on 2017/3/29.
//  Copyright © 2017年 tomxiang. All rights reserved.
//

#import "XXNetMonitorAFNetworking.h"
#import <AFNetworking/AFNetworking.h>

@implementation XXNetMonitorAFNetworking

+ (instancetype)sharedInstance
{
    static XXNetMonitorAFNetworking *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[XXNetMonitorAFNetworking alloc] init];
    });
    return sharedInstance;
}

- (void)startMonitorNetChange{
    
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
//        AFNetworkReachabilityStatusUnknown          = -1, //未知网络
//        AFNetworkReachabilityStatusNotReachable     = 0,  //没有网络连接
//        AFNetworkReachabilityStatusReachableViaWWAN = 1,  //手机网络
//        AFNetworkReachabilityStatusReachableViaWiFi = 2,  //WiFI
        
        NSLog(@"--status=%zd",status);
    }];
    
    [manager startMonitoring];
}

@end
