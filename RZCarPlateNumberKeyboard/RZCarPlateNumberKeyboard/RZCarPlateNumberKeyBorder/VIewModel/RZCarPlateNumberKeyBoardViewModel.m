//
//  RZCarPlateNumberKeyBoardViewModel.m
//  EntranceGuard
//
//  Created by 若醉 on 2018/5/18.
//  Copyright © 2018年 rztime. All rights reserved.
//

#import "RZCarPlateNumberKeyBoardViewModel.h"

@implementation RZCarPlateNumberKeyBoardViewModel

- (void)setShowProvinceKeyType:(BOOL)showProvinceKeyType {
    _showProvinceKeyType = showProvinceKeyType;
    
    if (showProvinceKeyType) {
        [self showProvince];
    } else {
        [self showABCD];
    }
}

- (NSMutableArray<NSArray<RZCarPlateNumberKeyBoardValue *> *> *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray new];
    }
    return _dataSource;
}

- (void)showProvince {
    [self.dataSource removeAllObjects];
    NSArray <NSArray <NSString *>*> *province = @[
                                      @[@"京",@"津",@"渝",@"沪",@"冀",@"晋",@"辽",@"吉",@"黑",@"苏"],
                                      @[@"浙",@"皖",@"闽",@"赣",@"鲁",@"豫",@"鄂",@"湘",@"粤",@"琼"],
                                      @[@"川",@"贵",@"云",@"陕",@"甘",@"青",@"蒙",@"桂",@"宁",@"新"],
                                      @[@"A",@"藏",@"使",@"领",@"警",@"学",@"港",@"澳", @"挂", @"delete"]
                                      ];
    [province enumerateObjectsUsingBlock:^(NSArray<NSString *> * _Nonnull objArray, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableArray *items = [NSMutableArray new];
        
        [objArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            RZCarPlateNumberKeyBoardValue *value = [[RZCarPlateNumberKeyBoardValue alloc] init];
            value.text = obj;
            if ([obj isEqualToString:@"A"]) {
                value.changeKeyBoardType = YES;
            } else if ([obj isEqualToString:@"delete"]) {
                value.deleteTextType = YES;
                value.image = [UIImage imageNamed:@"RZCarPlate.bundle/rzDelete"];
                value.text = nil;
            }
            [items addObject:value];
        }];
        
        [self.dataSource addObject:items.copy];
    }];
}

- (void)showABCD {
    [self.dataSource removeAllObjects];
    NSArray <NSArray <NSString *>*> *province = @[
                                                  @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0"],
                                                  @[@"Q",@"W",@"E",@"R",@"T",@"Y",@"U",@"I",@"O",@"P"],
                                                  @[@"A",@"S",@"D",@"F",@"G",@"H",@"J",@"K",@"L"],
                                                  @[@"省",@"Z",@"X",@"C",@"V",@"B",@"N",@"M",@"delete"]
                                                  ];
    [province enumerateObjectsUsingBlock:^(NSArray<NSString *> * _Nonnull objArray, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableArray *items = [NSMutableArray new];
        
        [objArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            RZCarPlateNumberKeyBoardValue *value = [[RZCarPlateNumberKeyBoardValue alloc] init];
            value.text = obj;
            if ([obj isEqualToString:@"省"]) {
                value.changeKeyBoardType = YES;
            } else if ([obj isEqualToString:@"delete"]) {
                value.deleteTextType = YES;
                value.image = [UIImage imageNamed:@"RZCarPlate.bundle/rzDelete"];
                value.text = nil;
            }
            [items addObject:value];
        }];
        
        [self.dataSource addObject:items.copy];
    }];
}

/**
 判断一下，当前text是否是省份
 */
+ (BOOL)isPorvince:(NSString *)text {
    NSString *provinces = @"京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领ABCDEFGHIGKLMNOPQRSTUVWXYZ";
    return [provinces containsString:text];
}
/**
 判断一下，第二位及以后是否是省份
 */
+ (BOOL)isProvinceByNotFitst:(NSString *)text {
    NSString *provinces = @"京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领";
    return [provinces containsString:text];
}

/**
 如果text中包含有省份，则删除字段
 */
+ (NSString *)removeProvince:(NSString *)text {
    __block NSString *plate = text.copy;
    NSArray *provinces = self.provincesOne;
    [provinces enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        plate = [plate stringByReplacingOccurrencesOfString:obj withString:@""];
    }];
    return plate;
}

+ (NSArray *)provincesOne {
    return @[@"京", @"津", @"沪", @"渝", @"冀", @"豫", @"云", @"辽", @"黑", @"湘", @"皖", @"鲁", @"新", @"苏", @"浙", @"赣", @"鄂", @"桂", @"甘", @"晋", @"蒙", @"陕", @"吉", @"闽", @"贵", @"粤", @"青", @"藏", @"川", @"宁", @"琼", @"使", @"领"];
}

@end
