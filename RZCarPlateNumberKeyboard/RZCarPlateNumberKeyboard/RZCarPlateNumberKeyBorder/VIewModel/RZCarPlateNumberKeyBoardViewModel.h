//
//  RZCarPlateNumberKeyBoardViewModel.h
//  EntranceGuard
//
//  Created by 若醉 on 2018/5/18.
//  Copyright © 2018年 rztime. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RZCarPlateNumberKeyBoardValue.h"


@interface RZCarPlateNumberKeyBoardViewModel : NSObject

/**
 是否显示省份的类型 会切换dataSource的值
 */
@property (nonatomic, assign) BOOL showProvinceKeyType;

@property (nonatomic, strong) NSMutableArray <NSArray <RZCarPlateNumberKeyBoardValue *> *> *dataSource;

/**
 判断一下，第一位是否是省份
 */
+ (BOOL)isPorvince:(NSString *)text;

/**
  判断一下，第二位及以后是否是省份 
 */
+ (BOOL)isProvinceByNotFitst:(NSString *)text;
/**
 如果text中包含有省份，则删除字段
 */
+ (NSString *)removeProvince:(NSString *)text;

@end
