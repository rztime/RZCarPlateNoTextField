//
//  RZCarPlateNoKeyBoardFlagView.m
//  RZCarPlateNoTextField
//
//  Created by Admin on 2018/12/10.
//  Copyright © 2018 Rztime. All rights reserved.
//

#import "RZCarPlateNoKeyBoardFlagView.h"

@implementation RZCarPlateNoKeyBoardFlagView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.imageView];
        [self addSubview:self.label];
        [self setconstraint:self.imageView];
        [self setconstraint:self.label];
    }
    return self;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        
    }
    return _imageView;
}

- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.font = [UIFont systemFontOfSize:30];
        _label.textAlignment = NSTextAlignmentCenter; 
    }
    self.imageView.image = [UIImage imageNamed:@"RZCarPlateNoResource.bundle/rzKeyBoardFlag"];
    return _label;
}

- (void)setconstraint:(UIView *)view {
    view.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:0 toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeft relatedBy:0 toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:0 toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeRight relatedBy:0 toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:0];
    [self addConstraints:@[top, left, bottom, right]];
}

@end
