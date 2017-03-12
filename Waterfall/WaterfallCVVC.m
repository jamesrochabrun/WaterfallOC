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

@interface WaterfallCVVC ()
@property (nonatomic, strong) UICollectionView *waterFallCV;

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
    
    self.collection = [NSMutableArray new];
    self.waterFallCV.dataSource = self;

    [self.waterFallCV setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];
    [self.waterFallCV registerClass:[UICollectionViewWaterfallCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.view addSubview:_waterFallCV];
    
    // Do any additional setup after loading the view.
    [self loadDummyData];
}



- (void)loadDummyData {
    
    ImageDetail *sasha = [[ImageDetail alloc] init];
    sasha.author = @"sasha";
    sasha.ruta_thumbnail = @"sasha";
    sasha.images = @"sasha";
    
    ImageDetail *zapatillas = [[ImageDetail alloc] init];
    zapatillas.author = @"zapatillas";
    zapatillas.ruta_thumbnail = @"zapatillas";
    zapatillas.images = @"zapatillas";
    
    ImageDetail *abrigo = [[ImageDetail alloc] init];
    abrigo.author = @"abrigo";
    abrigo.ruta_thumbnail = @"abrigo";
    abrigo.images = @"abrigo";
    
    ImageDetail *camisa = [[ImageDetail alloc] init];
    camisa.author = @"camisa";
    camisa.ruta_thumbnail = @"camisa";
    camisa.images = @"camisa";
    
    ImageDetail *crop = [[ImageDetail alloc] init];
    crop.author = @"crop";
    crop.ruta_thumbnail = @"crop";
    crop.images = @"crop";
    
    ImageDetail *lentes = [[ImageDetail alloc] init];
    lentes.author = @"lentes";
    lentes.ruta_thumbnail = @"lentes";
    lentes.images = @"lentes";
    
    ImageDetail *polera = [[ImageDetail alloc] init];
    polera.author = @"polera";
    polera.ruta_thumbnail = @"polera";
    polera.images = @"polera";
    
    ImageDetail *sombrero = [[ImageDetail alloc] init];
    sombrero.author = @"sombrero";
    sombrero.ruta_thumbnail = @"sombrero";
    sombrero.images = @"sombrero";
    
    NSLog(@"camisa %f", camisa.imageSizeH);
    
    UIImage *cami = [UIImage imageNamed:@"crop"];
    NSLog(@"WIDTH: %f", cami.size.width);

    [self.collection addObject:camisa];
    [self.collection addObject:crop];
    [self.collection addObject:sombrero];
    [self.collection addObject:sasha];
    [self.collection addObject:zapatillas];
    [self.collection addObject:abrigo];
    [self.collection addObject:lentes];
    [self.collection addObject:polera];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.collection.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    // Configure the cell
    ImageDetail *prenda = [[self collection] objectAtIndex:[indexPath item]];
    
    
    UICollectionViewWaterfallCell *cell =
    (UICollectionViewWaterfallCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier
                                                                               forIndexPath:indexPath];
    
    //[[cell productImageView] setImageWithURL:[NSURL URLWithString:[prenda images]]];
    cell.productImageView.image = [UIImage imageNamed:prenda.images];
    
    
    //[[cell avatarImageView] setImageWithURL:[NSURL URLWithString:[prenda ruta_thumbnail]]];
    cell.avatarImageView.image = [UIImage imageNamed:prenda.ruta_thumbnail];
    
    // Datos del owner
    cell.nameLabel.text = prenda.author;
    
    NSLog(@"prenda.author: %@",  prenda.author);


    cell.tag = indexPath.row;
    
    cell.imageDetail = [self.collection objectAtIndex:indexPath.row];
    
    return  cell;
}



#pragma mark - UICollectionViewWaterfallLayoutDelegate
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewWaterfallLayout *)collectionViewLayout
 heightForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ImageDetail *prenda = [[self collection] objectAtIndex:[indexPath item]];
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
