//
//  RZTextField.h
//  EntranceGuard
//
//  Created by 若醉 on 2018/5/2.
//  Copyright © 2018年 rztime. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RZTextField : UITextField

/**
 最大输入长度
 */
@property (nonatomic, assign) NSUInteger maxLength;
/**
 文本修改变化之后的回调,编辑结束完成也会走
 */
@property (nonatomic, copy) void(^rz_textEditChanged)(RZTextField *textField);

- (void)rz_textFieldEditChanged:(NSNotification *)sender;

@end
