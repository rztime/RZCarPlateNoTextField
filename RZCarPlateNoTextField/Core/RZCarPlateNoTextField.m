//
//  RZCarPlateNoTextField.m
//  RZCarPlateNoTextField
//
//  Created by Admin on 2018/12/10.
//  Copyright © 2018 Rztime. All rights reserved.
//

#import "RZCarPlateNoTextField.h"
#import "RZCarPlateNoKeyBoardView.h"
#import "RZCarPlateNoKeyBoardViewModel.h"

@interface RZCarPlateNoTextField ()

@property (nonatomic, strong) RZCarPlateNoKeyBoardView *keyBoardView;

@property (nonatomic, strong) UIView *tempInputView;

@end


@implementation RZCarPlateNoTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.rz_maxLength = 8;
        self.rz_checkCarPlateNoValue = YES;
        self.rz_isProvince = YES;
        self.rz_showCarPlateNoKeyBoard = YES;
    }
    return self;
}
- (void)setRz_showCarPlateNoKeyBoard:(BOOL)rz_showCarPlateNoKeyBoard {
    _rz_showCarPlateNoKeyBoard = rz_showCarPlateNoKeyBoard;
    if (_rz_showCarPlateNoKeyBoard) {
        if (![self.inputView isKindOfClass:[RZCarPlateNoKeyBoardView class]]) {
            self.tempInputView = self.inputView;
        }
        self.inputView = self.keyBoardView;
    } else {
        if ([self.inputView isKindOfClass:[RZCarPlateNoKeyBoardView class]]) {
           self.inputView = self.tempInputView;
        }
    }
}

- (void)rz_changeKeyBoard:(BOOL)showProvince {
    _rz_isProvince = showProvince;
    [self.keyBoardView rz_changeKeyBoard:showProvince];
}

- (BOOL)rz_isProvince {
    _rz_isProvince = self.keyBoardView.isProvince;
    return _rz_isProvince;
}

- (RZCarPlateNoKeyBoardView *)keyBoardView {
    if (!_keyBoardView) {
        _keyBoardView = [[RZCarPlateNoKeyBoardView alloc] init];
        __weak typeof(self) weakSelf = self;
        _keyBoardView.rz_keyboardEditing = ^(BOOL isDel, NSString * _Nonnull text) {
            [weakSelf rz_textFieldEdit:isDel text:text];
        };
    }
    return _keyBoardView;
}

- (void)rz_textFieldEdit:(BOOL)isDel text:(NSString *)text {
    NSString *originText = self.text;
    NSRange range = [self rz_selectedRange];
    if (self.rz_checkCarPlateNoValue && range.location > 0 && text.length > 0 && [rz_province containsString:text] && !isDel) {
        return ;
    }
    if (isDel) {
        if (range.location == 0 && range.length == 0) {
            if (self.rz_textFieldEditingValueChanged) {
                self.rz_textFieldEditingValueChanged(self);
            }
            return ;
        }
        if (range.length == 0) {
            range = NSMakeRange(MAX(0, range.location - 1), 1);
        }
        text = @"";
    }
    NSString *newText = [originText stringByReplacingCharactersInRange:range withString:text];
    NSString *tempNewText = newText.copy;
    if (self.rz_maxLength > 0) {
        tempNewText = [tempNewText substringWithRange:NSMakeRange(0, MIN(self.rz_maxLength, tempNewText.length))];
    }
    if (!isDel && self.rz_checkCarPlateNoValue) {
        if (self.rz_regexPlateNoIfYouNeed) {
            tempNewText = self.rz_regexPlateNoIfYouNeed(tempNewText);
        } else {
            tempNewText = [RZCarPlateNoKeyBoardViewModel rz_regexPlateNo:tempNewText];
        }
    }
    self.text = tempNewText;
    
    NSRange newRange = NSMakeRange(range.location + text.length, 0);
    if (!isDel && ![tempNewText isEqualToString:newText]) {
        NSInteger tempLength = 0;
        if ([self rz_inputIsAble:text location:range.location]) {
            tempLength = text.length;
        }
        newRange = NSMakeRange(MIN(range.location + tempLength, tempNewText.length), 0);
    }
    [self rz_setSelectedRange:newRange];
 
    if (self.rz_textFieldEditingValueChanged) {
        self.rz_textFieldEditingValueChanged(self);
    }
}

- (BOOL)rz_inputIsAble:(NSString *)text location:(NSInteger)location {
    if (text.length == 0) {
        return YES;
    }
    if (location == 0) {
        return [RZCarPlateNoKeyBoardViewModel rz_regexText:text regex:rz_province_Regex];
    }
    if (location == 1) {
        return [RZCarPlateNoKeyBoardViewModel rz_regexText:text regex:rz_province_code_Regex];
    }
    if (location == self.text.length - 1) {
        return [RZCarPlateNoKeyBoardViewModel rz_regexText:text regex:rz_plateNo_code_end_Regx];
    }
    return [RZCarPlateNoKeyBoardViewModel rz_regexText:text regex:rz_plateNo_code_Regex];
}

- (NSRange)rz_selectedRange {
    UITextPosition *beginning = self.beginningOfDocument;
    UITextRange    *selectedRange = self.selectedTextRange;
    UITextPosition *selectionStart = selectedRange.start;
    UITextPosition *selectionEnd = selectedRange.end;
    
    const NSInteger location = [self offsetFromPosition:beginning toPosition:selectionStart];
    const NSInteger length = [self offsetFromPosition:selectionStart toPosition:selectionEnd];
    return NSMakeRange(location, length);
}
-(void)rz_setSelectedRange:(NSRange)range {
    UITextPosition *beginning = self.beginningOfDocument;
    UITextPosition *startPosition = [self positionFromPosition:beginning offset:range.location];
    UITextPosition *endPosition = [self positionFromPosition:beginning offset:range.location + range.length];
    UITextRange    *selectionRange = [self textRangeFromPosition:startPosition toPosition:endPosition];
    [self setSelectedTextRange:selectionRange];
}

@end
