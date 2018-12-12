//
//  RZCarPlateNoKeyBoardCell.m
//  RZCarPlateNoTextField
//
//  Created by Admin on 2018/12/10.
//  Copyright © 2018 Rztime. All rights reserved.
//

#import "RZCarPlateNoKeyBoardCell.h"
#import "RZCarPlateNoKeyBoardFlagView.h"

#define rgba(r, g, b, a) [UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:a]
#define rgb(r, g, b) rgba(r, g, b, 1)

@interface RZCarPlateNoKeyBoardCell ()

@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) RZCarPlateNoKeyBoardFlagView *flagView;

@end

@implementation RZCarPlateNoKeyBoardCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self btn];
        [self imageView];
        [self flagView];
    }
    return self;
}

- (UIButton *)btn {
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn.titleLabel setAdjustsFontSizeToFitWidth:YES];
        [self.contentView addSubview:_btn];
        _btn.backgroundColor = [UIColor whiteColor];
        _btn.layer.cornerRadius = 3;
        [_btn setTitleColor:rgb(51, 51, 51) forState:UIControlStateNormal];
        [_btn addTarget:self action:@selector(touchDown) forControlEvents:UIControlEventTouchDown];
        [_btn addTarget:self action:@selector(touchUpInside) forControlEvents:UIControlEventTouchUpInside];
        [_btn addTarget:self action:@selector(touchUp) forControlEvents:UIControlEventTouchUpOutside];
        [_btn addTarget:self action:@selector(touchUp) forControlEvents:UIControlEventTouchCancel];
        _btn.translatesAutoresizingMaskIntoConstraints = NO;
        
        NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:_btn attribute:NSLayoutAttributeTop relatedBy:0 toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1 constant:8];
        NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:_btn attribute:NSLayoutAttributeLeft relatedBy:0 toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1 constant:2];
        NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:_btn attribute:NSLayoutAttributeBottom relatedBy:0 toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1 constant:-2];
        NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:_btn attribute:NSLayoutAttributeRight relatedBy:0 toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1 constant:-2];
        [self.contentView addConstraints:@[top, left, bottom, right]];
    }
    return _btn;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        [self.contentView addSubview:_imageView];
        _imageView.translatesAutoresizingMaskIntoConstraints = NO;
        
        NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeCenterX relatedBy:0 toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
        NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeCenterY relatedBy:0 toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
        [self.contentView addConstraints:@[centerX, centerY]];
    }
    return _imageView;
}
- (RZCarPlateNoKeyBoardFlagView *)flagView {
    if (!_flagView) {
        _flagView = [[RZCarPlateNoKeyBoardFlagView alloc] init];
        _flagView.hidden = YES;
        [self.contentView addSubview:_flagView];
        _flagView.translatesAutoresizingMaskIntoConstraints = NO;
        
        NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:_flagView attribute:NSLayoutAttributeCenterX relatedBy:0 toItem:_btn attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
        NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:_flagView attribute:NSLayoutAttributeBottom relatedBy:0 toItem:_btn attribute:NSLayoutAttributeTop multiplier:1 constant:3];
        
        NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:_flagView attribute:NSLayoutAttributeWidth relatedBy:0 toItem:_btn attribute:NSLayoutAttributeWidth multiplier:60.f/32.f constant:0];
        NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:_flagView attribute:NSLayoutAttributeHeight relatedBy:0 toItem:_flagView attribute:NSLayoutAttributeWidth multiplier:70.f/60.f constant:0];
        
        [self.contentView addConstraints:@[centerX, bottom, width, height]];
    }
    return _flagView;
}

- (void)setModel:(RZCarPlateNoKeyBoardCellModel *)model {
    _model = model;
    self.imageView.image = model.image;
    [self.btn setTitle:model.text forState:UIControlStateNormal];
    [self.btn setTitleColor:rgb(51, 51, 51) forState:UIControlStateNormal];
    self.flagView.label.text = model.text;
    
    [self resetColor];
}
- (void)resetColor {
    if (_model.rz_isChangedKeyBoardBtnType) {
        self.btn.backgroundColor = rgb(21,126,251);
        [self.btn setTitleColor:rgb(255, 255, 255) forState:UIControlStateNormal];
    } else if (_model.rz_isDeleteBtnType) {
        self.btn.backgroundColor = rgb(171, 178, 190);
    } else {
        self.btn.backgroundColor = [UIColor colorWithWhite:1 alpha:1];
    }
}

- (void)touchDown {
    if (self.model.text.length == 0) {
        return ;
    }
    self.flagView.hidden = NO;
}

- (void)touchUp {
    self.flagView.hidden = YES;
}

- (void)touchUpInside {
    self.flagView.hidden = YES;
    if (self.rz_clicked) {
        self.rz_clicked(self.indexPath);
    }
}

@end
