//
//  MSParallaxHorizonFlowLayout.m
//  
//
//  Created by JZJ on 2017/9/13.
//  Copyright © 2017年 JZJ. All rights reserved.
//
//  MIT License
//
//  Copyright (c) 2017 xjh093
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

#import "MSParallaxHorizonFlowLayout.h"

@interface MSParallaxHorizonFlowLayout()
@property (strong,  nonatomic) NSMutableArray   *attributesArray;
@property (nonatomic,  assign) CGFloat  onePageWidth;
@end

@implementation MSParallaxHorizonFlowLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        _showLastPageFull = YES;
        _pageWidth = [UIScreen mainScreen].bounds.size.width;
    }
    return self;
}

- (void)prepareLayout
{
    [super prepareLayout];
    
    _attributesArray = @[].mutableCopy;
    _onePageWidth = (_size.width + _columnSpacing) * _column - _columnSpacing;
    
    NSUInteger count = [self.collectionView numberOfItemsInSection:0];
    for (NSUInteger i = 0; i < count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        [_attributesArray addObject:attributes];
    }
}

//计算每个item的frame
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    NSInteger index = indexPath.item;
    
    NSInteger page = index / (_row * _column);
    
    // % 运算 确定 x 是 0,1,2 ... _column-1
    CGFloat x = (index % _column) * (_size.width + _columnSpacing) + page * (_onePageWidth + _columnSpacing) + self.sectionInset.left;
    // / 运算 确定 y 是 在哪行(一行有 column 个)， % 确定在 0,1,2 ... _row-1 行内的哪行
    CGFloat y = (index / _column % _row) * (_size.height + _rowSpacing) + self.sectionInset.top;
    
    attribute.frame = CGRectMake(x, y, _size.width, _size.height);
    
    return attribute;
    
}

//返回所有item的frame
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    return _attributesArray;
}

//返回总的可见尺寸
//避免一页未排满，滑动显示不全
- (CGSize)collectionViewContentSize{
    CGFloat width = (CGFloat)ceil(_attributesArray.count/(_row * _column * 1.0)) * _onePageWidth;
    if (!_showLastPageFull) {
        NSInteger lastCount = _attributesArray.count%(_row * _column);
        if (lastCount > 0 && lastCount < _column) {
            width = _attributesArray.count/(_row * _column) * _onePageWidth;
            width += (_size.width + _columnSpacing)*lastCount;
        }
    }
    width += self.sectionInset.left + self.sectionInset.right;
    CGFloat height = (_size.height + _rowSpacing) * _row + self.sectionInset.top + self.sectionInset.bottom;
    return CGSizeMake(width, height);
}

- (CGSize)collectionViewSize
{
    return CGSizeMake(_pageWidth, (_size.height + _rowSpacing) * _row + self.sectionInset.top + self.sectionInset.bottom);
}

@end
