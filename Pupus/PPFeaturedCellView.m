//
//  PPFeaturedCellView.m
//  Pupus
//
//  Created by Vinod Rathod on 08/03/15.
//  Copyright (c) 2015 Vinod Rathod. All rights reserved.
//

#import "PPFeaturedCellView.h"
#import "PPFeaturedCollectionViewCell.h"
#import "AppDelegate.h"
#import "HomeViewController.h"
#import "UIImageView+AFNetworking.h"
#import "SAMCache.h"

@interface PPFeaturedCellView()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@end


@implementation PPFeaturedCellView

-(void)awakeFromNib {


//    self.collectionView.backgroundColor = [UIColor colorWithRed:245/255.0f green:166/255.0f blue:35/255.0f alpha:0.87];
    self.collectionView.backgroundColor = [UIColor grayColor];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.itemSize = CGSizeMake(130.0, 170.0);
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 8.25, 0, 8.25);
    [self.collectionView setCollectionViewLayout:flowLayout];
    
    // Register the collection cell
    [self.collectionView registerNib:[UINib nibWithNibName:@"PPFeaturedCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"PPFeaturedCollectionViewCell"];
    
    
}

-(void)setCollectionData:(NSArray *)collectionData {
    _collectionData = collectionData;
    [self.collectionView reloadData];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.collectionData.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PPFeaturedCollectionViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"PPFeaturedCollectionViewCell" forIndexPath:indexPath];
    
    if (self.collectionData.count > 2) {
        NSString *key = [[NSString alloc]initWithFormat:@"%@",[self.collectionData objectAtIndex:indexPath.item]];
        
        UIImage *photo = [[SAMCache sharedCache]imageForKey:key];
        if (photo) {
            cell.imageView.image = photo;
            return cell;
        }
        
        NSURL *url = [[NSURL alloc]initWithString:key];
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                UIImage *image = [UIImage imageWithData:data];
                if (image) {
                    [[SAMCache sharedCache]setImage:image forKey:key];
                    cell.imageView.image = image;
                }
                
                
            });
        }];
        [task resume];
        
    }
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dictionary = @{
                                 @"item":indexPath,
                                 @"sectionId":self.sectionId
                                 };
    NSLog(@"%@",dictionary);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"collectionViewDidSelectItem" object:collectionView userInfo:dictionary];
    
}


@end
