//
//  RZCarPlateNoInputAlertView.m
//  RZCarPlateNoTextField
//
//  Created by Admin on 2018/12/11.
//  Copyright © 2018 Rztime. All rights reserved.
//

#import "RZCarPlateNoInputAlertView.h"
#import "RZCarPlateNoTextField.h"
#import "RZCarPlateNoKeyBoardViewModel.h"

@interface RZCarPlateNoInputAlertView ()

/** 默认 8 */
@property (nonatomic, assign) NSUInteger carPlateNoLength;

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIView                         *textFieldContentView;
@property (nonatomic, strong) NSMutableArray <RZCarPlateNoTextField *> *textFields;

@property (nonatomic, assign) CGFloat contentWidth;
@property (nonatomic, assign) CGFloat contentHeight;

@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *confirmButton;

@property (nonatomic, strong) NSMutableArray <NSString *> *plateInputs;

@property (nonatomic, copy) NSString *plateNo;

@end

@implementation RZCarPlateNoInputAlertView
- (instancetype)init {
    if (self = [super init]) {
        self.carPlateNoLength = 8;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    [self initContenSize];
    
    _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.contentWidth, self.contentHeight)];
    [self.view addSubview:_contentView];
    _contentView.center = self.view.center;
    _contentView.backgroundColor = [UIColor whiteColor];
    _contentView.layer.masksToBounds = YES;
    _contentView.layer.cornerRadius = 10;
    
    if (self.title.length > 0) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.contentWidth, 44)];
        [_contentView addSubview:_titleLabel];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = self.title;
        _titleLabel.font = [UIFont systemFontOfSize:14];
    }
    
    _textFieldContentView = [[UIView alloc] initWithFrame:CGRectMake(0, _titleLabel.frame.size.height, self.contentWidth, 60)];
    [_contentView addSubview:_textFieldContentView];
    
    _textFields = [NSMutableArray new];
    _plateInputs = [NSMutableArray new];
    __weak typeof(self) weakSelf = self;
    CGFloat textFieldWidth = (self.contentWidth - (5 * (self.carPlateNoLength+ 1))) / self.carPlateNoLength;
    for (NSInteger i = 0; i < self.carPlateNoLength; i ++) {
        [_plateInputs addObject:@""];
        
        RZCarPlateNoTextField *textField = [[RZCarPlateNoTextField alloc] initWithFrame:CGRectMake(5 + (i * (textFieldWidth + 5)), 8, textFieldWidth, 44)];
        textField.layer.borderWidth = 1;
        textField.layer.borderColor = [UIColor colorWithWhite:0.9 alpha:1].CGColor;
        textField.layer.masksToBounds = YES;
        textField.layer.cornerRadius = 3;
        textField.rz_showCarPlateNoKeyBoard = YES;
        textField.rz_checkCarPlateNoValue = NO;
        textField.textAlignment = NSTextAlignmentCenter;
        textField.rz_maxLength = i == self.carPlateNoLength - 1? 1 : 2; // 最后一个输入一位，其他输入2位，第二位的时候跳格到下一个
        [_textFieldContentView addSubview:textField];
        textField.tag = i;
        
        if (i != 0) {
            [textField rz_changeKeyBoard:NO];
        }
        
        [_textFields addObject:textField];
        
        textField.rz_textFieldEditingValueChanged = ^(RZCarPlateNoTextField * _Nonnull textField) {
            [weakSelf textFieldValueChanged:textField];
        };
    }
    
    _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancelButton.frame = CGRectMake(0, CGRectGetMaxY(_textFieldContentView.frame), self.contentWidth/2, 44);
    [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelButton setTitleColor:[UIColor colorWithWhite:0 alpha:0.8] forState:UIControlStateNormal];
    _cancelButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_contentView addSubview:_cancelButton];
    [_cancelButton addTarget:self action:@selector(cancelClicked) forControlEvents:UIControlEventTouchUpInside];
    
    
    _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirmButton.frame = CGRectMake(self.contentWidth/2, CGRectGetMaxY(_textFieldContentView.frame), self.contentWidth/2, 44);
    [_confirmButton setTitle:@"确认" forState:UIControlStateNormal];
    [_confirmButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    _confirmButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_contentView addSubview:_confirmButton];
    [_confirmButton addTarget:self action:@selector(confirmClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardLoacation:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    if (self.plateNo.length > 0) {
        [self initTextFields];
    }
}

- (void)keyboardLoacation:(NSNotification *)notification {
    NSDictionary *info = [notification userInfo];
    CGRect endKeyboardRect = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat centerY = endKeyboardRect.origin.y / 2.f;
    NSTimeInterval timer = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:timer animations:^{
        self.contentView.center = ({
            CGPoint center = self.contentView.center;
            center.y = centerY;
            center;
        });
    } completion:^(BOOL finished) {
        
    }];
}

- (void)initTextFields {
    NSInteger len = [self.plateNo length];
    for (int i=0; i<len; i++) {
        NSString *s= [self.plateNo substringWithRange:NSMakeRange(i, 1)];
        if (i >= self.carPlateNoLength) {
            return ;
        }
        [self.plateInputs replaceObjectAtIndex:i withObject:s];
        self.textFields[i].text = s;
    }
}

- (void)textFieldValueChanged:(RZCarPlateNoTextField *)textFiled {
    NSString *originText = self.plateInputs[textFiled.tag];
    NSString *newText = textFiled.text;
    
    RZCarPlateNoTextField *leftTextField = [self safeArrayAtIndex:textFiled.tag - 1];
    RZCarPlateNoTextField *rightTextField = [self safeArrayAtIndex:textFiled.tag + 1];
    
    RZCarPlateNoTextField *flagTextField;
    
    // 0 ..1
    if (originText.length == 0 && newText.length == 1) {
        [self.plateInputs replaceObjectAtIndex:textFiled.tag withObject:newText];
        flagTextField = rightTextField;
    } else if (originText.length == 1 && newText.length == 2) { // 1..2
        NSString *left = [newText substringToIndex:1];
        NSString *right = [newText substringFromIndex:1];
        textFiled.text = left;
        rightTextField.text = right;
        [self.plateInputs replaceObjectAtIndex:textFiled.tag withObject:left];
        if (rightTextField) {
            [self.plateInputs replaceObjectAtIndex:rightTextField.tag withObject:right];
            flagTextField = rightTextField;
        }
    } else if (originText.length == 1 && newText.length == 0){ // 1.。0
        [self.plateInputs replaceObjectAtIndex:textFiled.tag withObject:@""];
    } else if (originText.length == 0 && newText.length == 0){ // 0.。0
        [self.plateInputs replaceObjectAtIndex:textFiled.tag withObject:@""];
        flagTextField = leftTextField;
    }
    if([self regexPlateNo]) {
        flagTextField = textFiled;
    }
    if (flagTextField) {
        [flagTextField becomeFirstResponder];
    }
}

- (BOOL)regexPlateNo {
    NSString *province = self.plateInputs[0];
    NSString *provinceCode = self.plateInputs[1];
    
    NSString *last;
    NSInteger index = 2;
    for (NSInteger i = self.plateInputs.count - 1; i > 1; i--) {
        last = self.plateInputs[i];
        if (last.length > 0) {
            index = i;
            break;
        }
    }
    BOOL flag = NO;
    if (![RZCarPlateNoKeyBoardViewModel rz_regexText:province regex:rz_province_Regex]) {
        [self.plateInputs replaceObjectAtIndex:0 withObject:@""];
        flag = YES;
    }
    if (![RZCarPlateNoKeyBoardViewModel rz_regexText:provinceCode regex:rz_province_code_Regex]) {
        [self.plateInputs replaceObjectAtIndex:1 withObject:@""];
        flag = YES;
    }
    for (NSInteger i = 2; i < index; i++) {
        NSString *charText = self.plateInputs[i];
        if (![RZCarPlateNoKeyBoardViewModel rz_regexText:charText regex:rz_plateNo_code_Regex]) {
            [self.plateInputs replaceObjectAtIndex:i withObject:@""];
            flag = YES;
        }
    }
    if (![RZCarPlateNoKeyBoardViewModel rz_regexText:last regex:rz_plateNo_code_end_Regx]) {
        [self.plateInputs replaceObjectAtIndex:index withObject:@""];
        flag = YES;
    }
    if (flag) {
        __weak typeof(self) weakSelf = self;
        [self.plateInputs enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            weakSelf.textFields[idx].text = obj;
        }];
    }
    return flag;
}


- (RZCarPlateNoTextField *)safeArrayAtIndex:(NSInteger)index {
    if (index <= self.textFields.count - 1) {
        return self.textFields[index];
    }
    return nil;
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initContenSize {
    self.contentWidth = [UIScreen mainScreen].bounds.size.width * 0.8;
    if (self.contentWidth > 400) {
        self.contentWidth = 400;
    }
    if (self.title.length > 0) {
        self.contentHeight = 44 + 60 + 44;
    } else {
        self.contentHeight = 60 + 44;
    }
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (void)cancelClicked {
    [self dismissViewControllerAnimated:YES completion:^{
        if (self.complete) {
            self.complete(YES, @"");
        }
    }];
}
- (void)confirmClicked {
    NSString *plate = [self.plateInputs componentsJoinedByString:@""];
    plate = [plate stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];

    [self dismissViewControllerAnimated:YES completion:^{
        if (self.complete) {
            self.complete(NO, plate);
        }
    }];
}

#pragma mark - show
+ (instancetype)showToVC:(UIViewController *)vc plateNo:(NSString *)plateNo title:(NSString *)title plateLength:(NSUInteger)length complete:(RZCarPlateNoInputComplete)complete{
    RZCarPlateNoInputAlertView *key = [[RZCarPlateNoInputAlertView alloc] init];
    if (!title) {
        title = @"请输入车牌号";
    }
    key.carPlateNoLength = length;
    key.title = title;
    key.plateNo = plateNo;
    key.complete = complete;
    dispatch_async(dispatch_get_main_queue(), ^{
        BOOL flag = NO;
        flag = vc.definesPresentationContext;
        vc.definesPresentationContext = YES;
        key.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        key.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        if ((vc.navigationController.viewControllers.count == 1 && !vc.tabBarController) || vc.navigationController.viewControllers.count > 1) {
            [vc.navigationController presentViewController:key animated:YES completion:^{
                vc.definesPresentationContext = flag;
            }];
        } else if(vc.tabBarController){
            [vc.tabBarController presentViewController:key animated:YES completion:^{
                vc.definesPresentationContext = flag;
            }];
        } else {
            [vc presentViewController:key animated:YES completion:^{
                vc.definesPresentationContext = flag;
            }];
        }
    });
    return key;
}
@end
