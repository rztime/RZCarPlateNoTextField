//
//  RZCarPlateNumberKeyBoardCell.h
//  EntranceGuard
//
//  Created by 若醉 on 2018/5/18.
//  Copyright © 2018年 rztime. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RZCarPlateNumberKeyBoardValue.h"

@interface RZCarPlateNumberKeyBoardCell : UICollectionViewCell

@property (nonatomic, strong) RZCarPlateNumberKeyBoardValue *value;

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, copy) void(^didClicked)(NSIndexPath *indexPath);
@end
