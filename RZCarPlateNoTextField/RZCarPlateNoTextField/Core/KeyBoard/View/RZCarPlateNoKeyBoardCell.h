//
//  RZCarPlateNoKeyBoardCell.h
//  RZCarPlateNoTextField
//
//  Created by Admin on 2018/12/10.
//  Copyright © 2018 Rztime. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RZCarPlateNoKeyBoardCellModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface RZCarPlateNoKeyBoardCell : UICollectionViewCell

@property (nonatomic, strong) RZCarPlateNoKeyBoardCellModel *model;
@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, copy) void(^rz_clicked)(NSIndexPath *indexPath);

@end

NS_ASSUME_NONNULL_END
