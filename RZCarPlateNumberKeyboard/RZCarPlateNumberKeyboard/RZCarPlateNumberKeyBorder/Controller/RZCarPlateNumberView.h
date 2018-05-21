//
//  RZCarPlateNumberView.h
//  EntranceGuard
//
//  Created by 若醉 on 2018/5/18.
//  Copyright © 2018年 rztime. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CarPlateNumberComplete) (BOOL isCancel, NSString *plateNo);

@interface RZCarPlateNumberView : UIViewController

+ (instancetype)showToVC:(UIViewController *)vc plateNo:(NSString *)plateNo title:(NSString *)title plateLength:(NSUInteger)length complete:(CarPlateNumberComplete)complete;

@property (nonatomic, copy) CarPlateNumberComplete complete;

@end
