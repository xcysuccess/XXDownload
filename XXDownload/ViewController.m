//
//  ViewController.m
//  XXDownload
//
//  Created by tomxiang on 2017/2/21.
//  Copyright © 2017年 tomxiang. All rights reserved.
//

#import "ViewController.h"
#import "XXDownload.h"

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
    [[XXDownload sharedInstance] sync_connection];
}

- (IBAction)actionNSURLConnectionASYNC:(UIButton *)sender {
    [[XXDownload sharedInstance] async_connectionWithCompletion:^{
        NSLog(@"Completion Finished!");
    }];
}

- (IBAction)actionNSURLConnectionASYNC_Delegate:(id)sender {
    [[XXDownload sharedInstance] async_connectionWithDelegate];
}
- (IBAction)actionAsync_sessionDataTask:(id)sender {
    [[XXDownload sharedInstance] async_sessionDataTaskGet];

}
- (IBAction)actionAsync_sessionDataTaskPost:(id)sender {
    [[XXDownload sharedInstance] async_sessionDataTaskPost];

}
- (IBAction)actionAsync_sessionDataTaskDelegate:(id)sender {
    [[XXDownload sharedInstance] async_sessionDataTaskPostDelegate];
}
- (IBAction)actionAsync_sessionDataDownload:(id)sender {
    [[XXDownload sharedInstance] async_sessionDownloadImg];
}

@end
