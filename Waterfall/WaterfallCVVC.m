//
//  WaterfallCVVC.m
//  Waterfall
//
//  Created by James Rochabrun on 2/7/17.
//  Copyright © 2017 James Rochabrun. All rights reserved.
//

#import "WaterfallCVVC.h"
#import "UICollectionViewWaterfallLayout.h"
#import "ImageDetail.h"
#import "UICollectionViewWaterfallCell.h"
#import "WaterFallDataSource.h"

@interface WaterfallCVVC ()
@property (nonatomic, strong) UICollectionView *waterFallCV;
@property (nonatomic, strong) WaterFallDataSource *dataSource;

@end

@implementation WaterfallCVVC

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    self.waterFallCV.backgroundColor = [UIColor yellowColor];
    
    UICollectionViewWaterfallLayout *layout = [UICollectionViewWaterfallLayout new];
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    layout.delegate = self;
    layout.columnCount = 2;
    layout.itemWidth = self.view.frame.size.width / 2 ;
    //layout.sectionInset = UIEdgeInsetsMake(4, 4, 4, 4);

    
    CGRect frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    // _waterFallCollectionView = [_waterFallCollectionView initWithFrame:frame];
    _waterFallCV = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout: layout];
    [_waterFallCV registerClass:[UICollectionViewWaterfallCell self] forCellWithReuseIdentifier:@"Cell"];
    
    _dataSource = [WaterFallDataSource new];
    self.waterFallCV.dataSource = _dataSource;

    [self.waterFallCV setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];
    [self.waterFallCV registerClass:[UICollectionViewWaterfallCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.view addSubview:_waterFallCV];
    
    // Do any additional setup after loading the view.
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UICollectionViewWaterfallLayoutDelegate
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewWaterfallLayout *)collectionViewLayout
 heightForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ImageDetail *prenda = [_dataSource.collection objectAtIndex:[indexPath item]];
    [prenda loadImageData];

    
    // si no hay url, devuelve un tamaño "estándar" :)
    if (!prenda.images) {
        return 152 + 30;
    }
    
    // si no hay altura calculada, calcularla a partir del nombre de la imagen
    if (!prenda.imageSizeH) {
        
        [prenda setImageSizeH:152];
        
        // conseguir ancho y alto de la imagen
        NSString *widthString = nil;
        NSString *heightString = nil;
        
        // Create a regular expression with the pattern: Author
        NSRegularExpression *reg = [[NSRegularExpression alloc] initWithPattern:@"-(\\d{1,})x(\\d{1,})."
                                                                        options:0
                                                                          error:nil];
        
        // Find matches in the string. The range
        // argument specifies how much of the string to search;
        // in this case, all of it.
        NSArray *matches = [reg matchesInString:prenda.images
                                        options:0
                                          range:NSMakeRange(0, prenda.images.length)];
        
        // If there was a match
        if (matches.count == 1) {
            NSTextCheckingResult *result = [matches objectAtIndex:0];
            
            if (result.numberOfRanges == 3) {
                
                NSRange widthRange = [result rangeAtIndex:1];
                NSRange heightRange = [result rangeAtIndex:2];
                
                widthString = [prenda.images substringWithRange:widthRange];
                heightString = [prenda.images substringWithRange:heightRange];
                
                float ancho = widthString.floatValue;
                float alto = heightString.floatValue;
                
                [prenda setImageSizeH:(alto / ancho) * 152];
            }
        }
    }
    return prenda.imageSizeH + 30;
}


#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
