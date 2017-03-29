//
//  ViewController.m
//  XXDownload
//
//  Created by tomxiang on 2017/2/21.
//  Copyright © 2017年 tomxiang. All rights reserved.
//

#import "ViewController.h"
#import "XXURLOld.h"
#import "XXURLNew.h"
#import "XXDownloadImg.h"
#import "XXDownloadFile.h"

#import "XXURLAFNetworking.h"
#import "XXDownloadAFNetworking.h"
#import "XXNetMonitorAFNetworking.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionNSURLConnectionSYNC:(UIButton *)sender {
    [[XXURLOld sharedInstance] sync_connection];
}

- (IBAction)actionNSURLConnectionASYNC:(UIButton *)sender {
    [[XXURLOld sharedInstance] async_connectionWithCompletion:^{
        NSLog(@"Completion Finished!");
    }];
}

- (IBAction)actionNSURLConnectionASYNC_Delegate:(id)sender {
    [[XXURLOld sharedInstance] async_connectionWithDelegate];
}
- (IBAction)actionAsync_sessionDataTask:(id)sender {
    [[XXURLNew sharedInstance] async_sessionDataTaskGet];

}
- (IBAction)actionAsync_sessionDataTaskPost:(id)sender {
    [[XXURLNew sharedInstance] async_sessionDataTaskPost];

}
- (IBAction)actionAsync_sessionDataTaskDelegate:(id)sender {
    [[XXURLNew sharedInstance] async_sessionDataTaskPostDelegate];
}
- (IBAction)actionAsync_sessionDataDownload:(id)sender {
    [[XXDownloadImg sharedInstance] async_sessionDownloadImg];
}
- (IBAction)actionStart:(id)sender {
    [[XXDownloadFile sharedInstance] startDownloadFile];
}
- (IBAction)actionResume:(id)sender {
    [[XXDownloadFile sharedInstance] resumeDownloadFile];
}
- (IBAction)actionPause:(id)sender {
    [[XXDownloadFile sharedInstance] pauseDownloadFile];
}

- (IBAction)actionAFNetURL:(id)sender {
    [[XXURLAFNetworking sharedInstance] requestURL];
}

- (IBAction)actionAFNetDownImg:(id)sender {
    [[XXDownloadAFNetworking sharedInstance] downloadImg];

}
- (IBAction)actionAFNetStartMonitor:(id)sender {
    [[XXNetMonitorAFNetworking sharedInstance] startMonitorNetChange];
}
@end
