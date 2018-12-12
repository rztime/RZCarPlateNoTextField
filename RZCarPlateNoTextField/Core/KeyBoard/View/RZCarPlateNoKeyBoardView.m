//
//  RZCarPlateNoKeyBoardView.m
//  RZCarPlateNoTextField
//
//  Created by Admin on 2018/12/10.
//  Copyright © 2018 Rztime. All rights reserved.
//

#import "RZCarPlateNoKeyBoardView.h"
#import "RZCarPlateNoKeyBoardViewModel.h"
#import "RZCarPlateNoKeyBoardCell.h"

#define rz_kScreenWidth [UIScreen mainScreen].bounds.size.width
// 是否是iPhone X
#define rz_kiPhoneX (CGSizeEqualToSize(CGSizeMake(375.f, 812.f), [UIScreen mainScreen].bounds.size) || CGSizeEqualToSize(CGSizeMake(812.f, 375.f), [UIScreen mainScreen].bounds.size) || CGSizeEqualToSize(CGSizeMake(414.f, 896.f), [UIScreen mainScreen].bounds.size) || CGSizeEqualToSize(CGSizeMake(896.f, 414.f), [UIScreen mainScreen].bounds.size))
// 底部安全边距
#define rz_kSafeBottomMargin (rz_kiPhoneX ? 34.f: 0.f)

@interface RZCarPlateNoKeyBoardView ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, assign) CGFloat rz_cellHeight;
@property (nonatomic, assign) CGFloat rz_cellWidth;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) RZCarPlateNoKeyBoardViewModel *viewModel;

@end


@implementation RZCarPlateNoKeyBoardView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    self.rz_cellHeight = 54;
    self.rz_cellWidth = MIN(60, rz_kScreenWidth/10.f);
    frame = CGRectMake(0, 0, rz_kScreenWidth, self.rz_cellHeight * 4 + rz_kSafeBottomMargin + 10);
    if (self = [super initWithFrame:frame]) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        
        self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.collectionView.clipsToBounds = NO;
        [self addSubview:self.collectionView];
        self.collectionView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
        [self.collectionView registerClass:[RZCarPlateNoKeyBoardCell class] forCellWithReuseIdentifier:@"cell"];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.frame = CGRectMake(0, 0, rz_kScreenWidth, self.rz_cellHeight * 4 + rz_kSafeBottomMargin + 10);
    self.collectionView.frame =  CGRectMake(0, 0, rz_kScreenWidth, self.rz_cellHeight * 4 + 10);
    [self.collectionView reloadData];
}

- (RZCarPlateNoKeyBoardViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[RZCarPlateNoKeyBoardViewModel alloc] init];
        [_viewModel rz_changeKeyBoardType:YES];
    }
    return _viewModel;
}

- (void)rz_changeKeyBoard:(BOOL)showProvince {
    _isProvince = showProvince;
    [self.viewModel rz_changeKeyBoardType:showProvince];
    
    [self.collectionView reloadData];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.viewModel.dataSource.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.rz_cellWidth, self.rz_cellHeight);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.viewModel.dataSource[section] count];
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    NSArray *items = self.viewModel.dataSource[section];
    CGFloat width = self.rz_cellWidth * items.count;
    
    CGFloat leftMargin = 0;
    if (width < collectionView.bounds.size.width) {
        leftMargin = (collectionView.bounds.size.width - width)/2.f; // 保证所有按钮居中
    }
    
    return UIEdgeInsetsMake(0, leftMargin, 0, leftMargin);
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RZCarPlateNoKeyBoardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.model = self.viewModel.dataSource[indexPath.section][indexPath.row];
    cell.indexPath = indexPath;
    __weak typeof(self) weakSelf = self;
    cell.rz_clicked = ^(NSIndexPath * _Nonnull indexPath) {
        [weakSelf cellClickedIndexPath:indexPath];
    };
    return cell;
}

- (void)cellClickedIndexPath:(NSIndexPath *)indexPath {
    RZCarPlateNoKeyBoardCellModel *model = self.viewModel.dataSource[indexPath.section][indexPath.row];
    
    if (model.rz_isChangedKeyBoardBtnType) {
        [self.viewModel rz_changeKeyBoardType:!self.viewModel.isProvince];
        self.isProvince = self.viewModel.isProvince;
        [self.collectionView reloadData];
        return ;
    }
    if (self.rz_keyboardEditing) {
        self.rz_keyboardEditing(model.rz_isDeleteBtnType, model.text);
    }  
}

@end
