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
    
}

@end