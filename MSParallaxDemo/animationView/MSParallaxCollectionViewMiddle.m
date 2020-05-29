//
//  MSParallaxCollectionViewMiddle.m
//  
//
//  Created by  on 29/5/2019.
//  Copyright © 2019 JZJ. All rights reserved.
//

#import "MSParallaxCollectionViewMiddle.h"
#import "MSParallaxAnimationCell.h"

@implementation MSParallaxCollectionViewMiddle


- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell*) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString* url = self.dataArray[indexPath.item];
    MSParallaxAnimationCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MSParallaxAnimationCell" forIndexPath:indexPath];
    cell.imageUrl = url;
    return cell;
}


@end
