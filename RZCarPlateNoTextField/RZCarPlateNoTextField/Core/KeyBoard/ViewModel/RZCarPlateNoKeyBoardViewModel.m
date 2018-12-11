//
//  RZCarPlateNoKeyBoardViewModel.m
//  RZCarPlateNoTextField
//
//  Created by Admin on 2018/12/10.
//  Copyright © 2018 Rztime. All rights reserved.
//

#import "RZCarPlateNoKeyBoardViewModel.h"

NSString * const rz_province = @"京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领";
NSString * const rz_province_Regex = @"[京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领A-Z]";
NSString * const rz_province_code_Regex = @"[A-Z]";
NSString * const rz_plateNo_code_Regex = @"[A-Z0-9]";
NSString * const rz_plateNo_code_end_Regx = @"[A-Z0-9挂学警港澳]";

@interface RZCarPlateNoKeyBoardViewModel ()

@property (nonatomic, copy) NSArray *rz_provinces;
@property (nonatomic, copy) NSArray *rz_noAndChars;

@end

@implementation RZCarPlateNoKeyBoardViewModel

- (instancetype)init {
    if (self = [super init]) {
        _isProvince = YES;
        self.dataSource = self.rz_provinces;
    }
    return self;
}

- (NSArray *)rz_provinces {
    if (!_rz_provinces) {
        NSArray <NSArray <NSString *>*> *province = @[@[@"京",@"津",@"渝",@"沪",@"冀",@"晋",@"辽",@"吉",@"黑",@"苏"],
                                                      @[@"浙",@"皖",@"闽",@"赣",@"鲁",@"豫",@"鄂",@"湘",@"粤",@"琼"],
                                                      @[@"川",@"贵",@"云",@"陕",@"甘",@"青",@"蒙",@"桂",@"宁",@"新"],
                                                      @[@"A",@"藏",@"使",@"领",@"警",@"学",@"港",@"澳", @"挂", @"delete"]
                                                      ];
        NSMutableArray *array = [NSMutableArray new];
        [province enumerateObjectsUsingBlock:^(NSArray<NSString *> * _Nonnull objArray, NSUInteger idx, BOOL * _Nonnull stop) {
            NSMutableArray *rowItems = [NSMutableArray new];
            [objArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                RZCarPlateNoKeyBoardCellModel *model = [[RZCarPlateNoKeyBoardCellModel alloc] init];
                if ([obj isEqualToString:@"A"]) {
                    model.rz_isChangedKeyBoardBtnType = YES;
                    model.text = @"A";
                } else if ([obj isEqualToString:@"delete"]) {
                    model.rz_isDeleteBtnType = YES;
                    model.image = [UIImage imageNamed:@"RZCarPlateNoResource.bundle/rzDelete"];
                } else {
                    model.text = obj;
                }
                [rowItems addObject:model];
            }];
            [array addObject:rowItems];
        }];
        _rz_provinces = array.copy;
    }
    return _rz_provinces;
}

- (NSArray *)rz_noAndChars {
    if (!_rz_noAndChars) {
        NSArray <NSArray <NSString *>*> *province = @[
                                                      @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0"],
                                                      @[@"Q",@"W",@"E",@"R",@"T",@"Y",@"U",@"I",@"O",@"P"],
                                                      @[@"A",@"S",@"D",@"F",@"G",@"H",@"J",@"K",@"L"],
                                                      @[@"省",@"Z",@"X",@"C",@"V",@"B",@"N",@"M",@"delete"]
                                                      ];
        NSMutableArray *array = [NSMutableArray new];
        [province enumerateObjectsUsingBlock:^(NSArray<NSString *> * _Nonnull objArray, NSUInteger idx, BOOL * _Nonnull stop) {
            NSMutableArray *rowItems = [NSMutableArray new];
            [objArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                RZCarPlateNoKeyBoardCellModel *model = [[RZCarPlateNoKeyBoardCellModel alloc] init];
                if ([obj isEqualToString:@"省"]) {
                    model.rz_isChangedKeyBoardBtnType = YES;
                    model.text = @"省";
                } else if ([obj isEqualToString:@"delete"]) {
                    model.rz_isDeleteBtnType = YES;
                    model.image = [UIImage imageNamed:@"RZCarPlateNoResource.bundle/rzDelete"];
                } else {
                    model.text = obj;
                }
                [rowItems addObject:model];
            }];
            [array addObject:rowItems];
        }];
        _rz_noAndChars = array.copy;
    }
    return _rz_noAndChars;
}

- (void)rz_changeKeyBoardType:(BOOL)showProvince {
    if (showProvince) {
        self.dataSource = self.rz_provinces.copy;
    } else {
        self.dataSource = self.rz_noAndChars.copy;
    }
    _isProvince = showProvince;
}


/**
 校验分四步
 1.拆分出省份（或军用） 即第一位是省份或字母
 2.拆分出城市代码      即第二位是字母
 3.拆分出中间录入的代码 即第三位至第6位（或更多位）
 4.拆分出最后一位      即最后一位可能为字母、数字、也可能是特殊汉字（如 学、警、挂）
 
 @param plateNo ..
 @return 将不合规则的字符移除
 */
+ (NSString *)rz_regexPlateNo:(NSString *)plateNo {
    NSMutableString *newText = [NSMutableString new];
    if (plateNo.length == 0) {
        return @"";
    }
    // 1
    NSString *province = [plateNo substringWithRange:NSMakeRange(0, 1)];
    BOOL result = [self rz_regexText:province regex:rz_province_Regex];
    if (result) {
        [newText appendString:province];
    }
    if (plateNo.length == 1) {
        return newText;
    }
    // 2
    NSString *provinceCode = [plateNo substringWithRange:NSMakeRange(1, 1)];
    result = [self rz_regexText:provinceCode regex:rz_province_code_Regex];
    if (result) {
        [newText appendString:provinceCode];
    }
    if (plateNo.length == 2) {
        return newText;
    }
    // 3
    NSString *plateCode = [plateNo substringWithRange:NSMakeRange(2, plateNo.length - 3)];
    for(int i =0; i < [plateCode length]; i++) {
        NSString *temp = [plateCode substringWithRange:NSMakeRange(i, 1)];
        result = [self rz_regexText:temp regex:rz_plateNo_code_Regex];
        if (result) {
            [newText appendString:temp];
        }
    }
    // 4
    NSString *plateEnd = [plateNo substringWithRange:NSMakeRange(plateNo.length - 1, 1)];
    result = [self rz_regexText:plateEnd regex:rz_plateNo_code_end_Regx];
    if (result) {
        [newText appendString:plateEnd];
    }
    return newText;
}

+ (BOOL)rz_regexText:(NSString *)text regex:(NSString *)regex {
    NSString *regexText = [NSString stringWithFormat:@"^%@{%ld}$", regex, text.length];
    NSPredicate *regexResult = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regexText];
    return [regexResult evaluateWithObject:text];
}

@end
