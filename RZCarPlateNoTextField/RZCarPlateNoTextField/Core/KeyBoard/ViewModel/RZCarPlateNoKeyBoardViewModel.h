//
//  RZCarPlateNoKeyBoardViewModel.h
//  RZCarPlateNoTextField
//
//  Created by Admin on 2018/12/10.
//  Copyright © 2018 Rztime. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RZCarPlateNoKeyBoardCellModel.h"

extern NSString * const rz_province;
extern NSString * const rz_province_Regex;
extern NSString * const rz_province_code_Regex;
extern NSString * const rz_plateNo_code_Regex;
extern NSString * const rz_plateNo_code_end_Regx;

NS_ASSUME_NONNULL_BEGIN

@interface RZCarPlateNoKeyBoardViewModel : NSObject

@property (nonatomic, copy) NSArray <NSArray <RZCarPlateNoKeyBoardCellModel *> *> *dataSource;

@property (nonatomic, assign) BOOL isProvince;

- (void)rz_changeKeyBoardType:(BOOL)showProvince;


+ (NSString *)rz_regexPlateNo:(NSString *)plateNo;
+ (BOOL)rz_regexText:(NSString *)text regex:(NSString *)regex;

@end

NS_ASSUME_NONNULL_END
