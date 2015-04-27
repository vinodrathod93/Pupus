//
//  PPFeaturedCellView.h
//  Pupus
//
//  Created by Vinod Rathod on 08/03/15.
//  Copyright (c) 2015 Vinod Rathod. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"

@interface PPFeaturedCellView : UIView

@property (nonatomic) NSArray *collectionData;
@property (nonatomic) NSNumber *sectionId;

-(void)setCollectionData:(NSArray *)collectionData;
@end
