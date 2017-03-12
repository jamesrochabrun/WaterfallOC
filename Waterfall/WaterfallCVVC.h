//
//  WaterfallCVVC.h
//  Waterfall
//
//  Created by James Rochabrun on 2/7/17.
//  Copyright © 2017 James Rochabrun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UICollectionViewWaterfallLayout.h"

@interface WaterfallCVVC : UIViewController <UICollectionViewDelegateWaterfallLayout, UICollectionViewDataSource>
@property (strong, nonatomic) NSMutableArray *collection;

@end
