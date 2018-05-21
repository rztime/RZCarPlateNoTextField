//
//  RZCarPlateNumberKeyBoardValue.h
//  EntranceGuard
//
//  Created by 若醉 on 2018/5/18.
//  Copyright © 2018年 rztime. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RZCarPlateNumberKeyBoardValue : NSObject
@property (nonatomic, copy) NSString *text;

@property (nonatomic, strong) UIImage *image;

// 是否是切换键盘按钮
@property (nonatomic, assign) BOOL changeKeyBoardType;
// 是否是删除按钮
@property (nonatomic, assign) BOOL deleteTextType;
@end
