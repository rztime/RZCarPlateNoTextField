//
//  RZCarPlateNumberKeyBoard.m
//  EntranceGuard
//
//  Created by 若醉 on 2018/5/18.
//  Copyright © 2018年 rztime. All rights reserved.
//

#import "RZCarPlateNumberKeyBoard.h"
#import "RZCarPlateNumberKeyBoardViewModel.h"
#import "RZCarPlateNumberKeyBoardCell.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
// 是否是iPhone X
#define kiPhoneX (CGSizeEqualToSize(CGSizeMake(375.f, 812.f), [UIScreen mainScreen].bounds.size) || CGSizeEqualToSize(CGSizeMake(812.f, 375.f), [UIScreen mainScreen].bounds.size))
// 底部安全边距
#define kSafeBottomMargin (kiPhoneX ? 34.f: 0.f)
@interface RZCarPlateNumberKeyBoard ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) RZCarPlateNumberKeyBoardViewModel *viewModel;
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, assign) CGFloat keyboardItemHeight;
@property (nonatomic, assign) CGFloat keyboardItemWidth;
@end

@implementation RZCarPlateNumberKeyBoard

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame {
    [self initItemSize];
    frame.size.width = kScreenWidth;
    frame.origin.y = 0;
    frame.origin.x = 0;
    if (kiPhoneX) {
        frame.size.height = self.keyboardItemHeight * 4 + kSafeBottomMargin + 10;
    } else {
        frame.size.height = self.keyboardItemHeight * 4 + 10;
    }
    if (self = [super initWithFrame:frame]) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        
        self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        [self addSubview:self.collectionView];
        self.collectionView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
        [self.collectionView registerClass:[RZCarPlateNumberKeyBoardCell class] forCellWithReuseIdentifier:@"cell"];
    }
    return self;
}
// 重新布局
- (void)layoutSubviews {
    [super layoutSubviews];
    [self initItemSize];
    CGRect frame = self.bounds;
    frame.size.width = kScreenWidth;
    frame.origin.y = 0;
    frame.origin.x = 0;
    if (kiPhoneX) {
        frame.size.height = self.keyboardItemHeight * 4 + kSafeBottomMargin + 10;
    } else {
        frame.size.height = self.keyboardItemHeight * 4 + 10;
    }
    self.collectionView.frame = frame;
    [self.collectionView reloadData];
}

- (void)initItemSize {
    self.keyboardItemWidth = kScreenWidth / 10.f;
    if (self.keyboardItemWidth > 60) {
        self.keyboardItemWidth = 60;
    }
    
    self.keyboardItemHeight = 54;
}

- (RZCarPlateNumberKeyBoardViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[RZCarPlateNumberKeyBoardViewModel alloc] init];
        _viewModel.showProvinceKeyType = YES;
    }
    return _viewModel;
}

- (void)setShowProvinceKeyType:(BOOL)showProvinceKeyType {
    _showProvinceKeyType = showProvinceKeyType;
    
    self.viewModel.showProvinceKeyType = showProvinceKeyType;
    
    [self.collectionView reloadData];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.viewModel.dataSource.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.keyboardItemWidth, self.keyboardItemHeight);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.viewModel.dataSource[section] count];
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    NSArray *items = self.viewModel.dataSource[section];
    CGFloat width = self.keyboardItemWidth * items.count;
    
    CGFloat leftMargin = 0;
    if (width < collectionView.bounds.size.width) {
        leftMargin = (collectionView.bounds.size.width - width)/2.f; // 保证所有按钮居中
    }
    
    return UIEdgeInsetsMake(0, leftMargin, 0, leftMargin); 
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RZCarPlateNumberKeyBoardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.value = self.viewModel.dataSource[indexPath.section][indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    RZCarPlateNumberKeyBoardValue *value = self.viewModel.dataSource[indexPath.section][indexPath.row];
    if (value.changeKeyBoardType) {
        self.viewModel.showProvinceKeyType = !self.viewModel.showProvinceKeyType;
        [collectionView reloadData];
        return;
    }
    if (self.viewModel.showProvinceKeyType && !value.deleteTextType) {
        self.viewModel.showProvinceKeyType = NO;
        [collectionView reloadData];
    }
    if (self.keyboardEditing) {
        self.keyboardEditing(value.deleteTextType, value.text);
    }
}
@end

