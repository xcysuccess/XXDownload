//
//  XXURLAFNetworking.h
//  XXDownload
//
//  Created by tomxiang on 2017/3/29.
//  Copyright © 2017年 tomxiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XXURLAFNetworking : NSObject

+ (instancetype)sharedInstance;

-(void) requestURL;

@end
