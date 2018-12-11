//
//  RZCarPlateNoKeyBoardView.h
//  RZCarPlateNoTextField
//
//  Created by Admin on 2018/12/10.
//  Copyright © 2018 Rztime. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RZCarPlateNoKeyBoardView : UIView

@property (nonatomic, copy) void(^rz_keyboardEditing)(BOOL isDel, NSString *text);

/**
 改变键盘数据，

 @param showProvince 显示省份、特殊字
 */
- (void)rz_changeKeyBoard:(BOOL)showProvince;
@property (nonatomic, assign) BOOL isProvince; // 当前是否是省份

@end

NS_ASSUME_NONNULL_END
