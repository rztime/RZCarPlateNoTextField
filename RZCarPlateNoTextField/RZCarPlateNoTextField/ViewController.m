//
//  ViewController.m
//  RZCarPlateNoTextField
//
//  Created by Admin on 2018/12/10.
//  Copyright © 2018 Rztime. All rights reserved.
//

#import "ViewController.h"
#import "RZCarPlateNoTextField.h"
#import "RZCarPlateNoInputAlertView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    RZCarPlateNoTextField *textfield = [[RZCarPlateNoTextField alloc] initWithFrame:CGRectMake(10, 100, 300, 50)];
    textfield.backgroundColor = [UIColor colorWithWhite:0.7 alpha:1];
//    textfield.rz_maxLength = 0;
//    textfield.rz_checkCarPlateNoValue = NO;
    [self.view addSubview:textfield];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(10, 300, 300, 50);
    [btn setTitle:@"车牌号输入" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(alert) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)alert {
    [RZCarPlateNoInputAlertView showToVC:self plateNo:@"" title:@"请输入车牌号" plateLength:8 complete:^(BOOL isCancel, NSString * _Nonnull plateNo) {
        NSLog(@"plateNo:%@", plateNo);
    }];
}

@end
