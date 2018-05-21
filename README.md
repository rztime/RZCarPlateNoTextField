# RZCarPlateNumberKeyboard (iOS 车牌号 键盘)
iOS 车牌号键盘 对UITextField封装一个专用车牌号输入键盘

对键盘的inputView做了一个替换，输入项只能选择输入车牌号（省区（或特殊车牌）+数字字母）

* RZCarPlateNumberKeyBorder
    * RZCarPlateNumberKeyBoard   
        * 作为UITextField.inputView使用，如需使用，需要完成文字新增、插入、删除、替换等等方法，自定义完成UITextField的输入事件
    * RZCarPlateTextField
        * 对UITextField.inputView在UITextField.inputView中的一次封装，直接使用时，可只录入车牌号，可设置最大输入字符长度。
    * RZCarPlateNumberView
        * 以ViewController的形式，弹出框样式输入车牌号

## 使用RZCarPlateNumberKeyboard

* RZCarPlateTextField
```
_plateTextField = [[RZCarPlateTextField alloc] initWithFrame:CGRectMake(30, 100, 250, 44)];
[self.view addSubview:_plateTextField];
```
* RZCarPlateNumberView 
```
// 只有输入了 7 位，确认按钮点击才有效
[RZCarPlateNumberView showToVC:self plateNo:@"川A12" title:@"请输入车牌号" plateLength:7 complete:^(BOOL isCancel, NSString *plateNo) {
if (isCancel) {
NSLog(@"点击了取消");
return ;
}
NSLog(@"车牌号:%@", plateNo);
}];
```
