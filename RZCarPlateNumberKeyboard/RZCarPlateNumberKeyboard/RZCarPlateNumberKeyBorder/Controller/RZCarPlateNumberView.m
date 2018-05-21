//
//  RZCarPlateNumberView.m
//  EntranceGuard
//
//  Created by 若醉 on 2018/5/18.
//  Copyright © 2018年 rztime. All rights reserved.
//

#import "RZCarPlateNumberView.h"
#import "RZCarPlateTextField.h"
#import "RZCarPlateNumberKeyBoardViewModel.h"

@interface RZCarPlateNumberView ()

/** 默认 7 */
@property (nonatomic, assign) NSUInteger carPlateNo;

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIView                         *textFieldContentView;
@property (nonatomic, strong) NSMutableArray <RZCarPlateTextField *> *textFields;

@property (nonatomic, assign) CGFloat contentWidth;
@property (nonatomic, assign) CGFloat contentHeight;

@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *confirmButton;

@property (nonatomic, strong) NSMutableArray <NSString *> *plateInputs;

@property (nonatomic, copy) NSString *plateNo;
@end

@implementation RZCarPlateNumberView

- (instancetype)init {
    if (self = [super init]) {
        self.carPlateNo = 7;
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
    CGFloat textFieldWidth = (self.contentWidth - (5 * (self.carPlateNo+ 1))) / self.carPlateNo;
    for (NSInteger i = 0; i < self.carPlateNo; i ++) {
        [_plateInputs addObject:@""];
        
        RZCarPlateTextField *textField = [[RZCarPlateTextField alloc] initWithFrame:CGRectMake(5 + (i * (textFieldWidth + 5)), 8, textFieldWidth, 44)];
        textField.layer.borderWidth = 1;
        textField.layer.borderColor = [UIColor colorWithWhite:0.9 alpha:1].CGColor;
        textField.layer.masksToBounds = YES;
        textField.layer.cornerRadius = 3;
        textField.showCarPlateKeyBoard = YES;
        textField.checkCarPlateValue = NO;
        textField.textAlignment = NSTextAlignmentCenter;
        textField.maxLength = 1;
        [_textFieldContentView addSubview:textField];
        textField.tag = i;
        textField.showProvinceKeyType = i == 0? YES:NO;
        
        [_textFields addObject:textField];
        
        textField.rz_textEditChanged = ^(RZTextField *textField) {
            [weakSelf textFieldValueChanged:(RZCarPlateTextField *)textField];
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
        NSLog(@"%@",s);
        if (i >= self.carPlateNo) {
            return ;
        }
        
        [self.plateInputs replaceObjectAtIndex:i withObject:s];
        self.textFields[i].text = s;
    }
}

- (void)textFieldValueChanged:(RZCarPlateTextField *)textFiled {
    BOOL flag = YES;
    if (textFiled.tag == 0 && textFiled.text.length > 0) {
        if (![RZCarPlateNumberKeyBoardViewModel isPorvince:textFiled.text]) {
            textFiled.text = @"";
            textFiled.showProvinceKeyType = YES;
        }
    } else if (textFiled.text.length > 0){
        textFiled.text = [RZCarPlateNumberKeyBoardViewModel removeProvince:textFiled.text];
        flag = NO;
    }
    
    NSString *old = self.plateInputs[textFiled.tag];
    if (old.length > 0 && textFiled.text.length == 0) {
        flag = NO;
    }
    
    [self.plateInputs replaceObjectAtIndex:textFiled.tag withObject:textFiled.text];
    
    if (textFiled.text.length == 0 && textFiled.tag > 0) {
        if (flag) {
            [self.textFields[textFiled.tag - 1] becomeFirstResponder];
        }
    } else if (textFiled.text.length > 0 && textFiled.tag < self.carPlateNo - 1){
        [self.textFields[textFiled.tag + 1] becomeFirstResponder];
    }
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
            self.complete(YES, nil);
        }
    }];
}
- (void)confirmClicked {
    NSString *plate = [self.plateInputs componentsJoinedByString:@""];
    plate = [plate stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (plate.length < self.carPlateNo) {
        return ;
    }
    [self dismissViewControllerAnimated:YES completion:^{
        if (self.complete) {
            self.complete(NO, plate);
        }
    }];
}

#pragma mark - show
+ (instancetype)showToVC:(UIViewController *)vc plateNo:(NSString *)plateNo title:(NSString *)title plateLength:(NSUInteger)length complete:(CarPlateNumberComplete)complete{
    RZCarPlateNumberView *key = [[RZCarPlateNumberView alloc] init];
    if (!title) {
        title = @"请输入车牌号";
    }
    key.carPlateNo = length;
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
