//
//  MSParallaxAnimationCell.m
//  
//
//  Created by JZJ on 2019/4/22.
//  Copyright © 2019 JZJ. All rights reserved.
//

#import "MSParallaxAnimationCell.h"

@interface MSParallaxAnimationCell()

@property(nonatomic,strong)UIImageView* imageView;

@end

@implementation MSParallaxAnimationCell

- (void)setImageUrl:(NSString *)imageUrl{
    
    self.imageView.image = [UIImage imageNamed:imageUrl];
}

-(UIImageView *)imageView{
    if(!_imageView){
        _imageView= [UIImageView new];
        _imageView.frame = self.bounds;
        [self.contentView addSubview:_imageView];
    }
    return _imageView;
}

@end
