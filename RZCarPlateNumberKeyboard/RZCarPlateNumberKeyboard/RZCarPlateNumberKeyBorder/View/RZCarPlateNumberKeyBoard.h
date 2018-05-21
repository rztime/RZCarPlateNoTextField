//
//  RZCarPlateNumberKeyBoard.h
//  EntranceGuard
//
//  Created by 若醉 on 2018/5/18.
//  Copyright © 2018年 rztime. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RZCarPlateNumberKeyBoard : UIView

- (instancetype)initWithFrame:(CGRect)frame;

/**
 是否显示省份的类型 会切换dataSource的值
 */
@property (nonatomic, assign) BOOL showProvinceKeyType;
/**
 键盘点击事件
 del：退格删除按钮点击
 text：输入的文字
 */
@property (nonatomic, copy) void(^keyboardEditing)(BOOL del, NSString *text);

@end
