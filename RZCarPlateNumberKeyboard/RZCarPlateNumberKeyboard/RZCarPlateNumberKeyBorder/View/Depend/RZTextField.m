//
//  RZTextField.m
//  EntranceGuard
//
//  Created by 若醉 on 2018/5/2.
//  Copyright © 2018年 rztime. All rights reserved.
//

#import "RZTextField.h"
#import <RZColorful.h>

@implementation RZTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.maxLength = NSIntegerMax;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rz_textFieldEditChanged:) name:UITextFieldTextDidChangeNotification object:self];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rz_textFieldEditChanged:) name:UITextFieldTextDidEndEditingNotification object:self];
    }
    return self;
}

- (void)rz_textFieldEditChanged:(NSNotification *)sender {
    RZTextField *textField = sender.object;
    if (![textField isEqual:self]) {
        return;
    }
    if (self.maxLength == NSIntegerMax) {
        if (self.rz_textEditChanged) {
            self.rz_textEditChanged(textField);
        }
        return;
    }
    
    NSString *toBeString = textField.text;

    NSRange range = [self selectedRange];
    // 键盘输入模式
    NSString *lang = [[UIApplication sharedApplication]textInputMode].primaryLanguage;
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > self.maxLength) {
                textField.text = [toBeString substringToIndex:self.maxLength];
            }
        }
        // 有高亮选择的字符串，则暂不对文字进行统计和限制
        else{
            
        }
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else{
        if (toBeString.length > self.maxLength) {
            textField.text = [toBeString substringToIndex:self.maxLength];
        }
    }
    if (range.location > textField.text.length) {
        range.location = textField.text.length;
    }
    [self setSelectedRange:range];
    if (self.rz_textEditChanged) {
        self.rz_textEditChanged(textField);
    }
}


- (void)dealloc {
    NSLog(@"%s 销毁了", __FUNCTION__);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
