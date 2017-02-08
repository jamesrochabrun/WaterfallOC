//
//  ImageDetail.h
//  Waterfall
//
//  Created by James Rochabrun on 2/7/17.
//  Copyright © 2017 James Rochabrun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageDetail : NSObject

@property (nonatomic) NSString *idImage;
@property (nonatomic) NSString *author;
@property (nonatomic) NSString *images;
@property (nonatomic) NSString *ruta_thumbnail;
@property (nonatomic) NSData   *thumbnailData;
@property (nonatomic) NSString *emailfriend;
@property (nonatomic) NSData   *imageData;
@property (nonatomic) CGFloat   imageSizeH;

- (void) loadImageData;


@end
