//
//  UICollectionViewWaterfallCell.h
//  Waterfall
//
//  Created by James Rochabrun on 2/7/17.
//  Copyright © 2017 James Rochabrun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageDetail.h"

@interface UICollectionViewWaterfallCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIImageView *productImageView;
@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UIView *avatarImageContainerView;

@property (nonatomic, weak) ImageDetail *imageDetail;

- (void)formatProductImageView;
- (void)formatAvatarImageContainerView;

@end
