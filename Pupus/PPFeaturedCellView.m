//
//  PPFeaturedCellView.m
//  Pupus
//
//  Created by Vinod Rathod on 08/03/15.
//  Copyright (c) 2015 Vinod Rathod. All rights reserved.
//

#import "PPFeaturedCellView.h"
#import "PPFeaturedCollectionViewCell.h"

@interface PPFeaturedCellView()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *collectionData;
@end


@implementation PPFeaturedCellView

-(void)awakeFromNib {

    self.collectionView.backgroundColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1.0];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.itemSize = CGSizeMake(130.0, 170.0);
    [self.collectionView setCollectionViewLayout:flowLayout];
    
    // Register the collection cell
    [self.collectionView registerNib:[UINib nibWithNibName:@"PPFeaturedCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"PPFeaturedCollectionViewCell"];

}

-(void)setCollectionData:(NSArray *)collectionData {
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PPFeaturedCollectionViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"PPFeaturedCollectionViewCell" forIndexPath:indexPath];
    return cell;
}

//-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    
//}

@end
