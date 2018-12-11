//
//  RZCarPlateNoKeyBoardCellModel.h
//  RZCarPlateNoTextField
//
//  Created by Admin on 2018/12/10.
//  Copyright © 2018 Rztime. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RZCarPlateNoKeyBoardCellModel : NSObject

@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) UIImage *image;


@property (nonatomic, assign) BOOL rz_isChangedKeyBoardBtnType;
@property (nonatomic, assign) BOOL rz_isDeleteBtnType;

@end

NS_ASSUME_NONNULL_END
