//
//  RZCarPlateNoInputAlertView.h
//  RZCarPlateNoTextField
//
//  Created by Admin on 2018/12/11.
//  Copyright © 2018 Rztime. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^RZCarPlateNoInputComplete) (BOOL isCancel, NSString *plateNo);

@interface RZCarPlateNoInputAlertView : UIViewController

+ (instancetype)showToVC:(UIViewController *)vc plateNo:(NSString *)plateNo title:(NSString *)title plateLength:(NSUInteger)length complete:(RZCarPlateNoInputComplete)complete;

@property (nonatomic, copy) RZCarPlateNoInputComplete complete;

@end

NS_ASSUME_NONNULL_END
