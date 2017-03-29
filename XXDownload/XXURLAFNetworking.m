//
//  XXURLAFNetworking.m
//  XXDownload
//
//  Created by tomxiang on 2017/3/29.
//  Copyright © 2017年 tomxiang. All rights reserved.
//

#import "XXURLAFNetworking.h"
#import <AFNetworking/AFNetworking.h>

#define JSON_URL @"http://new.api.bandu.cn/book/listofgrade?id=2"

#define JSON_URL_FRONT @"http://new.api.bandu.cn/book/listofgrade"

@implementation XXURLAFNetworking


+ (instancetype)sharedInstance
{
    static XXURLAFNetworking *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[XXURLAFNetworking alloc] init];
    });
    return sharedInstance;
}

-(void) requestURL{
    //1.定义一个管理器
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    
    
    //修改响应序列化
    session.responseSerializer = [AFJSONResponseSerializer serializer];
    NSMutableSet *newSet = [NSMutableSet set];
    // 添加我们需要的类型
    newSet.set = session.responseSerializer.acceptableContentTypes;
    [newSet addObject:@"text/html"];
    // 重写给 acceptableContentTypes赋值
    session.responseSerializer.acceptableContentTypes = newSet;
    
    //参数
    NSDictionary *dict = @{@"grade_id":@"2"};
    
    [session POST:JSON_URL parameters:dict progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"当前的进度：%lf",downloadProgress.completedUnitCount*1.f / downloadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 请求成功，解析数据
        NSLog(@"%@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", [error localizedDescription]);
    }];
}

@end
