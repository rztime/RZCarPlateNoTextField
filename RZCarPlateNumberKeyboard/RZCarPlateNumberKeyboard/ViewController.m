//
//  ViewController.m
//  RZCarPlateNumberKeyboard
//
//  Created by 若醉 on 2018/5/21.
//  Copyright © 2018年 rztime. All rights reserved.
//

#import "ViewController.h"
#import "RZCarPlateTextField.h"
#import "RZCarPlateNumberView.h"


@interface ViewController ()

@property (nonatomic, strong) RZCarPlateTextField *plateTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _plateTextField = [[RZCarPlateTextField alloc] initWithFrame:CGRectMake(30, 100, 250, 44)];
    _plateTextField.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    [self.view addSubview:_plateTextField];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor orangeColor];
    [button setTitle:@"车牌号输入" forState:UIControlStateNormal];
    [self.view addSubview:button];
    button.frame = CGRectMake(30, 200, 250, 44);
    
    [button addTarget:self action:@selector(plateAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)plateAction {
    [RZCarPlateNumberView showToVC:self plateNo:@"川A12" title:@"请输入车牌号" plateLength:7 complete:^(BOOL isCancel, NSString *plateNo) {
        if (isCancel) {
            NSLog(@"点击了取消");
            return ;
        }
        NSLog(@"车牌号:%@", plateNo);
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
