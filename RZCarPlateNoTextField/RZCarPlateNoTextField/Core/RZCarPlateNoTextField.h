//
//  RZCarPlateNoTextField.h
//  RZCarPlateNoTextField
//
//  Created by Admin on 2018/12/10.
//  Copyright © 2018 Rztime. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RZCarPlateNoTextField : UITextField

/**
 是否显示车牌号键盘 默认YES
 */
@property (nonatomic, assign) BOOL rz_showCarPlateNoKeyBoard;
/**
 最大输入长度，默认为8
 为0时，不限制输入长度
 */
@property (nonatomic, assign) NSUInteger rz_maxLength;

/**
 是否需要校验车牌号值类型（第一位为省份或特殊号牌，中间为数字或字母，最后可能为汉字）默认YES
 */
@property (nonatomic, assign) BOOL rz_checkCarPlateNoValue;


/**
 校验文本，如果你有更好的方法或者新的规则需要校验车牌号，这里可以做校验，将校验之后的text返回,将替换我的校验方法
 */
@property (nonatomic, copy) NSString *(^rz_regexPlateNoIfYouNeed)(NSString *text);

// 文字有变化之后的回调
@property (nonatomic, copy) void(^rz_textFieldEditingValueChanged)(RZCarPlateNoTextField *textField);

/**
 改变键盘s数据，
 
 @param showProvince 显示省份、特殊字
 */
- (void)rz_changeKeyBoard:(BOOL)showProvince;
@property (nonatomic, assign) BOOL rz_isProvince; // 当前是否是省份 默认YES

@end

NS_ASSUME_NONNULL_END
