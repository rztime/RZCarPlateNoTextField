//
//  RZCarPlateTextField.m
//  EntranceGuard
//
//  Created by 若醉 on 2018/5/18.
//  Copyright © 2018年 rztime. All rights reserved.
//

#import "RZCarPlateTextField.h"
#import "RZCarPlateNumberKeyBoard.h"
#import "RZCarPlateNumberKeyBoardViewModel.h"
#import <RZColorful.h>

@interface RZCarPlateTextField ()

@property (nonatomic, strong) RZCarPlateNumberKeyBoard *carPlateKeyBoard;

@end

@implementation RZCarPlateTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.showCarPlateKeyBoard = YES;
        self.checkCarPlateValue = YES;
    }
    return self;
}

- (RZCarPlateNumberKeyBoard *)carPlateKeyBoard {
    if (!_carPlateKeyBoard) {
        _carPlateKeyBoard = [[RZCarPlateNumberKeyBoard alloc] initWithFrame:CGRectZero];
        if (self.maxLength == NSIntegerMax) {
            self.maxLength = 7;
        }
        
        __weak typeof(self) weakSelf = self;
        _carPlateKeyBoard.keyboardEditing = ^(BOOL del, NSString *text) {
            [weakSelf textFieldShouldDelete:del orAddText:text];
        };
    }
    return _carPlateKeyBoard;
}

- (void)setShowCarPlateKeyBoard:(BOOL)showCarPlateKeyBoard {
    _showCarPlateKeyBoard = showCarPlateKeyBoard;
    
    if (showCarPlateKeyBoard) {
        self.inputView = self.carPlateKeyBoard;
    } else {
        if ([self.inputView isKindOfClass:[RZCarPlateNumberKeyBoard class]]) {
            self.inputView = nil;
        }
    }
}

- (void)setShowProvinceKeyType:(BOOL)showProvinceKeyType {
    _showProvinceKeyType = showProvinceKeyType; 
    self.carPlateKeyBoard.showProvinceKeyType = showProvinceKeyType;
}

- (void)textFieldShouldDelete:(BOOL)del orAddText:(NSString *)text {
    NSMutableString *oldText = self.text.mutableCopy;
    NSRange range = [self selectedRange];
    if (del) {
        if (range.location == 0 && range.length == 0) {
            
        } else if(range.length == 0 && range.location > 0){
            range.location -= 1;
            range.length = 1;
        }
        [oldText deleteCharactersInRange:range];
        range.length = 0;
    } else {
        if (range.location == 0) {
            if (![RZCarPlateNumberKeyBoardViewModel isPorvince:text] && self.checkCarPlateValue) {
                self.carPlateKeyBoard.showProvinceKeyType = YES;
                return ;
            }
        }
        if (range.location > 0) {
            if ([RZCarPlateNumberKeyBoardViewModel isPorvince:text]  && self.checkCarPlateValue) {
                self.carPlateKeyBoard.showProvinceKeyType = NO;
                return ;
            }
        }
        if (range.length > 0) {
            [oldText replaceCharactersInRange:range withString:text];
        } else {
            [oldText insertString:text atIndex:range.location];
        }
        range.location += text.length;
        range.length = 0;
    }
    if (oldText.length > 1 && self.checkCarPlateValue) {
        NSString *checkPlate = [oldText substringFromIndex:1];
        checkPlate = [RZCarPlateNumberKeyBoardViewModel removeProvince:checkPlate];
        oldText = [[oldText substringToIndex:1] stringByAppendingString:checkPlate].mutableCopy;
    }
    
    self.text = oldText.copy;
    if (range.location > self.text.length) {
        range.location = self.text.length;
    }
    [self setSelectedRange:range];
    NSNotification *notice = [[NSNotification alloc] initWithName:UITextFieldTextDidChangeNotification object:self userInfo:nil];
    [super rz_textFieldEditChanged:notice];
}

@end
