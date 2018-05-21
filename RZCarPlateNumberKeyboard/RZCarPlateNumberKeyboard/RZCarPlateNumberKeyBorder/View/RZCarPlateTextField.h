//
//  RZCarPlateTextField.h
//  EntranceGuard
//
//  Created by 若醉 on 2018/5/18.
//  Copyright © 2018年 rztime. All rights reserved.
//

#import "RZTextField.h"

@interface RZCarPlateTextField : RZTextField

/**
 显示车牌号输入 默认YES
 */
@property (nonatomic, assign) BOOL showCarPlateKeyBoard;
/**
 是否验证车牌号输入值，默认为YES，只能第一位为省份，其他为字母或数字
 */
@property (nonatomic, assign) BOOL checkCarPlateValue;

/**
 是否显示省份的类型 会切换dataSource的值
 */
@property (nonatomic, assign) BOOL showProvinceKeyType;

@end
