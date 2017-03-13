//
//  WaterFallDataSource.h
//  Waterfall
//
//  Created by James Rochabrun on 3/12/17.
//  Copyright © 2017 James Rochabrun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WaterFallDataSource : NSObject<UICollectionViewDataSource>
@property (nonatomic, strong) NSMutableArray *collection;

@end
