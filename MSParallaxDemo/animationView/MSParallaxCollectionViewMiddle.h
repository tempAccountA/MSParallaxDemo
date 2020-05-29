//
//  MSParallaxCollectionViewMiddle.h
//  
//
//  Created by  on 29/5/2019.
//  Copyright © 2019 JZJ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MSParallaxCollectionViewMiddle : UICollectionView<UICollectionViewDelegate,
                                                     UICollectionViewDataSource>

@property(nonatomic,strong)NSMutableArray* dataArray;

@end

NS_ASSUME_NONNULL_END
