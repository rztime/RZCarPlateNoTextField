# RZCarPlateNoTextField (iOS 车牌号 键盘)
iOS 车牌号键盘 对UITextField封装一个专用车牌号输入键盘

对键盘的inputView做了一个替换，输入项只能选择输入车牌号（省（或特殊车牌）+数字字母+特殊汉字）

* RZCarPlateNoTextField 包含两个主要使用类
    * RZCarPlateNoTextField   
        * 继承自UITextField，
        * 可设置是否显示车牌号输入键盘
        * 最大输入长度 （0 不限制长度）
        * rz_regexPlateNoIfYouNeed（block方法） 可自行设计车牌号校验格式，参考[RZCarPlateNoKeyBoardViewModel rz_regexPlateNo:]方法，我的校验方法不是最好的，只是一个初步思路。
        * rz_textFieldEditingValueChanged 输入变化之后的回调
    * RZCarPlateNoInputAlertView
        * 以ViewController的形式，alert弹出框样式输入车牌号

## 使用RZCarPlateNoTextField

* RZCarPlateNoTextField
```
    RZCarPlateNoTextField *textfield = [[RZCarPlateNoTextField alloc] initWithFrame:CGRectMake(10, 100, 300, 50)];
//    textfield.backgroundColor = [UIColor colorWithWhite:0.7 alpha:1];
//    textfield.rz_maxLength = 0;  // 最大输入长度 （0 不限制）
//    textfield.rz_checkCarPlateNoValue = NO;  // 是否需要校验车牌号输入规则
//    textfield.rz_regexPlateNoIfYouNeed = ^NSString * _Nonnull(NSString * _Nonnull text) {
//        // 你的校验方法,
//        return text;
//    };
//    textfield.rz_textFieldEditingValueChanged = ^(RZCarPlateNoTextField * _Nonnull textField) {
//        NSLog(@"输入变化回调：%@", textField.text);
//    };
//    [textfield rz_changeKeyBoard:NO]; // 代码控制显示字母 （YES：省份）
    [self.view addSubview:textfield];
```
* RZCarPlateNoInputAlertView
```
[RZCarPlateNoInputAlertView showToVC:self plateNo:@"" title:@"请输入车牌号" plateLength:8 complete:^(BOOL isCancel, NSString * _Nonnull plateNo) {
    NSLog(@"plateNo:%@", plateNo);
    }];
}];
```

![键盘样式(省区)](https://github.com/rztime/RZCarPlateNoTextField/blob/master/%E5%8C%BA.png)
![键盘样式(数字字母)](https://github.com/rztime/RZCarPlateNoTextField/blob/master/%E6%95%B0%E5%AD%97%E5%AD%97%E6%AF%8D.png)

![键盘样式(弹出窗样式)](https://github.com/rztime/RZCarPlateNoTextField/blob/master/%E5%BC%B9%E5%87%BA.png)

